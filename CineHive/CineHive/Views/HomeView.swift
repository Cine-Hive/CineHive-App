//
//  HomeView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = MovieViewModel()
    @State private var scrollOffset: CGFloat = 0
    @State private var showProfileOptions = false
    @State private var selectedCategory: MovieCategory?
    @State private var showNotification = false
    @State private var isRefreshing = false
    @State private var notificationMessage = "최신 OTT 랭킹 정보가 업데이트 되었습니다"
    @State private var selectedOTTFilter: OTTService? = nil
    @State private var showRankingDetail = false
    
    // App style colors
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    private let secondaryColor = Color.gray
    
    // Sample banner items
    private let bannerItems: [BannerItem] = [
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/original/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg"),
            title: "오늘의 추천 콘텐츠",
            subtitle: "인셉션"
        ),
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/original/8s4h9friP6Ci3adRGahHARVd76E.jpg"),
            title: "넷플릭스 TOP",
            subtitle: "인터스텔라"
        ),
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/original/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg"),
            title: "디즈니+ 신규 콘텐츠",
            subtitle: "엘리멘탈"
        )
    ]
    
    // Extended movie categories
    private let categories: [MovieCategory] = [
        MovieCategory(title: "현재 상영 영화", type: .nowPlaying),
        MovieCategory(title: "넷플릭스 TOP 10", type: .netflixMovies),
        MovieCategory(title: "디즈니+ TOP 10", type: .disneyMovies),
        MovieCategory(title: "애플TV+ TOP 10", type: .appleTVMovies)
    ]
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            ScrollViewReader { scrollProxy in
                ScrollView {
                    // GeometryReader for scroll detection
                    GeometryReader { geometry in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self,
                                              value: geometry.frame(in: .named("scrollView")).minY)
                    }
                    .frame(height: 0)
                    
                    VStack(spacing: 0) {
                        // Custom refresh indicator
                        CustomRefreshView(isRefreshing: isRefreshing)
                        
                        // Banner Section - with proper image sizing
                        featuredBannerSection()
                            .id("top")
                        
                        // 종합 랭킹 섹션 (추가)
                        OverallRankingSection(viewModel: viewModel)
                            .id("overallRanking")
                        
                        // OTT Filter Section
                        ottFilterSection()
                            .padding(.top, 20)
                        
                        if selectedOTTFilter != nil {
                            // Show content specific to the selected OTT
                            ottSpecificContent(for: selectedOTTFilter!)
                        } else {
                            // OTT Ranking Section
                            OTTRankingSection(viewModel: viewModel)
                            
                            // Header: OTT별 콘텐츠 정보
                            contentByOttHeader()
                            
                            // All OTT sections
                            allOTTsSection()
                        }
                        
                        // My List Section (if user is logged in)
                        myListSection()
                        
                        // Footer with information
                        footerSection()
                        
                        // Footer space
                        Color.clear.frame(height: 50)
                    }
                    .onChange(of: selectedCategory) { _, _ in
                        if selectedCategory != nil {
                            withAnimation {
                                scrollProxy.scrollTo("selectedCategory", anchor: .top)
                            }
                        }
                    }
                }
                .coordinateSpace(name: "scrollView")
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                }
                .refreshable {
                    await refreshContent()
                }
            }
        }
        .overlay(
            VStack {
                // Animated header
                customNavigationBar()
                Spacer()
            }
        )
        .foregroundColor(textColor)
        .statusBar(hidden: scrollOffset < -20)
        .sheet(isPresented: $showProfileOptions) {
            ProfileOptionsView()
        }
        .sheet(isPresented: $showRankingDetail) {
            FullRankingView()
        }
        .notification(
            isPresented: $showNotification,
            message: notificationMessage,
            icon: "bell.fill",
            accentColor: accentColor
        )
        .onAppear {
            if viewModel.movies.isEmpty {
                viewModel.fetchMovies()
                
                // Show welcome notification after a short delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    notificationMessage = "CineHive에 오신 것을 환영합니다! 다양한 OTT의 콘텐츠 정보를 확인해보세요."
                    withAnimation {
                        showNotification = true
                    }
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    private func customNavigationBar() -> some View {
        ZStack {
            // Background with blur effect based on scroll
            Rectangle()
                .fill(backgroundColor.opacity(scrollOffset < 0 ? 0.9 : 0))
                .animation(.easeInOut(duration: 0.3), value: scrollOffset < 0)
                .frame(height: 50)
            
            HStack {
                Text("CineHive")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(accentColor)
                
                Spacer()
                
                HStack(spacing: 20) {
                    Button {
                        // Navigate to search
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(textColor)
                            .font(.system(size: 18))
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    Button {
                        withAnimation(.spring(response: 0.3)) {
                            showProfileOptions.toggle()
                        }
                        
                        // Add haptic feedback
                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                        impactFeedback.impactOccurred()
                    } label: {
                        Image(systemName: "person.circle")
                            .foregroundColor(textColor)
                            .font(.system(size: 18))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, 15)
        }
    }
    
    private func featuredBannerSection() -> some View {
        TabView {
            ForEach(bannerItems) { item in
                NavigationLink(destination: DetailView(movieId: Int.random(in: 100...999))) {
                    FeaturedBannerItemView(item: item)
                }
                .buttonStyle(.plain) // Removes default button styling
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 250) // Adjusted height
        .background(backgroundColor)
    }
    
    private func ottFilterSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("OTT별 콘텐츠 보기")
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.leading, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    // All OTTs button
                    Button {
                        withAnimation(.spring(duration: 0.3)) {
                            selectedOTTFilter = nil
                        }
                    } label: {
                        OTTFilterButton(
                            iconName: "rectangle.grid.2x2",
                            text: "모든 OTT",
                            color: accentColor,
                            isSelected: selectedOTTFilter == nil
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    // Individual OTT buttons
                    ForEach(OTTService.allCases, id: \.self) { ott in
                        Button {
                            withAnimation(.spring(duration: 0.3)) {
                                selectedOTTFilter = ott
                            }
                        } label: {
                            OTTFilterButton(
                                iconName: ott.iconName,
                                text: ott.name,
                                color: ott.color,
                                isSelected: selectedOTTFilter == ott
                            )
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
            }
        }
    }
    
    private func ottSpecificContent(for ott: OTTService) -> some View {
        VStack(spacing: 20) {
            // OTT Header
            HStack {
                Image(systemName: ott.iconName)
                    .font(.system(size: 24))
                    .foregroundColor(ott.color)
                
                Text("\(ott.name) 콘텐츠")
                    .font(.title3)
                    .bold()
                    .foregroundColor(textColor)
                
                Spacer()
            }
            .padding(.horizontal, 15)
            .padding(.top, 30)
            
            // OTT Info Card
            OTTInfoCard(service: ott, showReleaseDate: false)
                .padding(.horizontal, 15)
            
            // Top Content Section
            VStack(alignment: .leading) {
                Text("\(ott.name) TOP 10")
                    .font(.headline)
                    .foregroundColor(textColor)
                    .padding(.leading, 15)
                    .padding(.top, 10)
                
                EnhancedMovieListView(
                    movies: getDummyMoviesFor(ott: ott),
                    movieType: .etc,
                    viewModel: viewModel
                )
            }
            
            // Categories Section
            if let category = categories.first(where: { getCategoryOTT($0) == ott }) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("\(ott.name) 인기 콘텐츠")
                            .font(.headline)
                            .foregroundColor(textColor)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                selectedCategory = category
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text("더 보기")
                                    .font(.subheadline)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(secondaryColor)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 20)
                    
                    EnhancedMovieListView(
                        movies: getDummyMoviesFor(category: category.type),
                        movieType: category.type,
                        viewModel: viewModel
                    )
                }
            }
            
            // Cross-OTT Comparison section
            if let movie = viewModel.movies.first {
                Text("OTT 서비스 비교")
                    .font(.headline)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    .padding(.top, 20)
                
                CrossOTTComparisonView(movie: movie)
                    .padding(.top, 5)
            }
        }
    }
    
    private func contentByOttHeader() -> some View {
        Text("OTT별 콘텐츠 정보")
            .font(.title3)
            .bold()
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 15)
            .padding(.top, 30)
            .padding(.bottom, 10)
    }
    
    private func allOTTsSection() -> some View {
        VStack(spacing: 20) {
            // Show all OTT sections
            ForEach(categories) { category in
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: getOTTIcon(for: category.type))
                            .foregroundColor(getOTTColor(for: category.type))
                            .font(.system(size: 20))
                        
                        Text(category.title)
                            .font(.headline)
                            .foregroundColor(textColor)
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                selectedCategory = category
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Text("더 보기")
                                    .font(.subheadline)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(secondaryColor)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 20)
                    
                    // Enhanced movie list view for a better experience
                    EnhancedMovieListView(
                        movies: getDummyMoviesFor(category: category.type),
                        movieType: category.type,
                        viewModel: viewModel
                    )
                }
            }
        }
    }
    
    private func myListSection() -> some View {
        VStack(alignment: .leading) {
            Text("내가 저장한 콘텐츠")
                .font(.title3)
                .bold()
                .foregroundColor(textColor)
                .padding(.leading, 15)
                .padding(.top, 30)
            
            // Use EnhancedMovieListView
            EnhancedMovieListView(
                movies: Array(getDummyMoviesFor(category: .nowPlaying).prefix(5)),
                movieType: .nowPlaying,
                viewModel: viewModel
            )
        }
    }
    
    private func footerSection() -> some View {
        VStack(spacing: 10) {
            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(.top, 20)
            
            Text("CineHive는 다양한 OTT 서비스의 콘텐츠 정보를 제공합니다")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.top, 10)
            
            HStack(spacing: 20) {
                ottLogo("n.square.fill", color: .red)
                ottLogo("d.square.fill", color: .blue)
                ottLogo("apple.logo", color: .gray)
                ottLogo("w.square.fill", color: .cyan)
                ottLogo("t.square.fill", color: .red)
            }
            .padding(.top, 5)
            
            Text("CineHive는 각 OTT 서비스와 제휴관계가 없으며, 콘텐츠 정보만 제공합니다")
                .font(.caption)
                .foregroundColor(.gray.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
                .padding(.top, 5)
        }
        .padding(.top, 20)
        .padding(.bottom, 30)
    }
    
    private func ottLogo(_ iconName: String, color: Color) -> some View {
        Image(systemName: iconName)
            .font(.system(size: 20))
            .foregroundColor(color)
    }
    
    // MARK: - Helper Methods
    
    private func refreshContent() async {
        isRefreshing = true
        
        // Add some delay to simulate network request
        try? await Task.sleep(nanoseconds: 1_500_000_000)
        
        viewModel.fetchMovies()
        
        // Show notification after refresh
        notificationMessage = "OTT 콘텐츠 정보가 최신으로 업데이트되었습니다"
        
        isRefreshing = false
        
        // Show notification after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                showNotification = true
            }
        }
    }
    
    private func getDummyMoviesFor(category: MovieListType) -> [Movie] {
        if category == .nowPlaying {
            return viewModel.movies
        } else {
            // Generate random movies for different categories with different counts based on category
            let count = category == .netflixMovies ? 10 : (category == .disneyMovies ? 8 : 6)
            return (0..<count).map { _ in
                Movie(
                    id: Int.random(in: 100...999),
                    posterPath: "/\(["9Gtg2DzBhmYamXBS1hKAhiwbBKS", "t6HIqrRAclMzcQm5ynoNekJtgxY", "7WsyChQLEftFiDOVTGkv3hFpyyt", "vZloFAK7NmvMCKE7XmjxvC5wekX", "qNBAXBIQlnOThrVvA6mA2B5ggV6"].randomElement()!).jpg",
                    backDropPath: "/\(["mDeUmPe4MF35WWlAqj4QFX5UuLf", "pWsRl1DBQkEEzXNvO7WXnCX6f61", "xzdnhKjvOMQzYgXY9oMRgVCGHFY"].randomElement()!).jpg"
                )
            }
        }
    }
    
    private func getDummyMoviesFor(ott: OTTService) -> [Movie] {
        // Generate random movies for the specific OTT
        let count = 10
        return (0..<count).map { _ in
            Movie(
                id: Int.random(in: 100...999),
                posterPath: "/\(["9Gtg2DzBhmYamXBS1hKAhiwbBKS", "t6HIqrRAclMzcQm5ynoNekJtgxY", "7WsyChQLEftFiDOVTGkv3hFpyyt", "vZloFAK7NmvMCKE7XmjxvC5wekX", "qNBAXBIQlnOThrVvA6mA2B5ggV6"].randomElement()!).jpg",
                backDropPath: "/\(["mDeUmPe4MF35WWlAqj4QFX5UuLf", "pWsRl1DBQkEEzXNvO7WXnCX6f61", "xzdnhKjvOMQzYgXY9oMRgVCGHFY"].randomElement()!).jpg"
            )
        }
    }
    
    private func getOTTIcon(for type: MovieListType) -> String {
        switch type {
        case .netflixMovies: return "n.square.fill"
        case .disneyMovies: return "d.square.fill"
        case .appleTVMovies: return "apple.logo"
        default: return "film"
        }
    }
    
    private func getOTTColor(for type: MovieListType) -> Color {
        switch type {
        case .netflixMovies: return .red
        case .disneyMovies: return .blue
        case .appleTVMovies: return .gray
        default: return .white
        }
    }
    
    private func getCategoryOTT(_ category: MovieCategory) -> OTTService? {
        switch category.type {
        case .netflixMovies: return .netflix
        case .disneyMovies: return .disney
        case .appleTVMovies: return .apple
        default: return nil
        }
    }
}

// MARK: - Full Ranking View

struct FullRankingView: View {
    @Environment(\.dismiss) private var dismiss
    
    private let categories = ["종합 랭킹", "넷플릭스", "디즈니+", "애플TV+", "웨이브", "티빙"]
    @State private var selectedCategory = "종합 랭킹"
    @State private var timeRange = "이번 주"
    
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // Header with dismiss button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .padding()
                    }
                    
                    Spacer()
                    
                    Text("콘텐츠 랭킹")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Empty view to balance the layout
                    Image(systemName: "xmark")
                        .foregroundColor(.clear)
                        .font(.system(size: 18))
                        .padding()
                }
                .background(backgroundColor)
                
                // Category selector
                categorySelector()
                
                // Time range selector
                timeRangeSelector()
                
                // Ranking list
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(1...30, id: \.self) { rank in
                            OverallRankingItemView(rank: rank)
                                .padding(.vertical, 8)
                            
                            if rank < 30 {
                                Divider()
                                    .background(Color.gray.opacity(0.2))
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
    
    private func categorySelector() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(categories, id: \.self) { category in
                    Button {
                        withAnimation {
                            selectedCategory = category
                        }
                    } label: {
                        Text(category)
                            .font(.system(size: 15, weight: selectedCategory == category ? .bold : .regular))
                            .foregroundColor(selectedCategory == category ? .white : .gray)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(selectedCategory == category ? accentColor : Color.clear)
                            .cornerRadius(16)
                    }
                }
            }
            .padding()
        }
    }
    
    private func timeRangeSelector() -> some View {
        HStack {
            Button {
                timeRange = "오늘"
            } label: {
                Text("오늘")
                    .font(.system(size: 14))
                    .foregroundColor(timeRange == "오늘" ? .white : .gray)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(timeRange == "오늘" ? Color.gray.opacity(0.3) : Color.clear)
                    .cornerRadius(12)
            }
            
            Button {
                timeRange = "이번 주"
            } label: {
                Text("이번 주")
                    .font(.system(size: 14))
                    .foregroundColor(timeRange == "이번 주" ? .white : .gray)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(timeRange == "이번 주" ? Color.gray.opacity(0.3) : Color.clear)
                    .cornerRadius(12)
            }
            
            Button {
                timeRange = "이번 달"
            } label: {
                Text("이번 달")
                    .font(.system(size: 14))
                    .foregroundColor(timeRange == "이번 달" ? .white : .gray)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(timeRange == "이번 달" ? Color.gray.opacity(0.3) : Color.clear)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 8)
    }
}

// MARK: - Helper Components

struct OTTFilterButton: View {
    let iconName: String
    let text: String
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.system(size: 14))
            
            Text(text)
                .font(.system(size: 14, weight: isSelected ? .semibold : .regular))
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 8)
        .background(isSelected ? color : Color.gray.opacity(0.15))
        .foregroundColor(isSelected ? .white : .gray)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isSelected ? color : Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

// MARK: - Supporting Structures & Extensions

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct MovieGridView: View {
    let movies: [Movie]
    @State var viewModel: MovieViewModel
    
    // Adjusted columns to show only 2 in a row for better visibility
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(movies, id: \.id) { movie in
                NavigationLink(destination: DetailView(movieId: movie.id)) {
                    VStack(alignment: .leading, spacing: 6) {
                        PosterView(posterURL: movie.posterURL, width: 160, height: 240)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        
                        Text("영화 \(movie.id)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .frame(width: 160, alignment: .leading)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 12))
                            Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            // OTT availability
                            Image(systemName: getOTTIcon(for: movie.id))
                                .foregroundColor(getOTTColorBasedOnID(for: movie.id))
                                .font(.system(size: 12))
                        }
                    }
                    .padding(.bottom, 10)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    
    // Helper to get an OTT icon based on movie ID (for demo)
    private func getOTTIcon(for id: Int) -> String {
        switch id % 4 {
        case 0: return "n.square.fill"
        case 1: return "d.square.fill"
        case 2: return "apple.logo"
        default: return "w.square.fill"
        }
    }
    
    // Helper to get an OTT color based on movie ID (for demo)
    private func getOTTColorBasedOnID(for id: Int) -> Color {
        switch id % 4 {
        case 0: return .red
        case 1: return .blue
        case 2: return .gray
        default: return .cyan
        }
    }
}

struct ProfileOptionsView: View {
    private let backgroundColor = Color.black
    private let textColor = Color.white
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Spacer()
                Button {
                    // Dismiss sheet
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(textColor)
                        .padding()
                }
            }
            
            Text("프로필 및 더보기")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
            
            profileSelectionSection()
            
            optionsSection()
            
            Spacer()
        }
        .padding()
        .background(backgroundColor)
    }
    
    private func profileSelectionSection() -> some View {
        VStack(spacing: 15) {
            ForEach(["사용자 1", "사용자 2", "게스트"], id: \.self) { profile in
                HStack {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(.gray)
                    
                    Text(profile)
                        .font(.headline)
                        .foregroundColor(textColor)
                    
                    Spacer()
                    
                    if profile == "사용자 1" {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
                .padding(.vertical, 5)
            }
            
            Button {
                // Add profile
            } label: {
                HStack {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 24))
                    Text("프로필 추가")
                        .font(.headline)
                    Spacer()
                }
                .foregroundColor(.gray)
                .padding(.top, 10)
            }
        }
        .padding()
    }
    
    private func optionsSection() -> some View {
        VStack(spacing: 25) {
            optionRow(icon: "square.and.pencil", title: "프로필 관리")
            optionRow(icon: "star.fill", title: "즐겨찾기 관리")
            optionRow(icon: "bell", title: "알림 설정")
            optionRow(icon: "gear", title: "설정")
            optionRow(icon: "questionmark.circle", title: "도움말")
            optionRow(icon: "arrow.right.square", title: "로그아웃")
        }
        .padding()
    }
    
    private func optionRow(icon: String, title: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 22))
                .frame(width: 24)
            
            Text(title)
                .font(.headline)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .foregroundColor(textColor)
    }
}

// MARK: - Preview
#Preview {
    NavigationView {
        HomeView()
    }
}
