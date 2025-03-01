//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI
import AVKit

struct DetailView2: View {
    let movieId: Int
    @State private var viewModel = MovieViewModel()
    @State private var isOverviewExpanded: Bool = false
    @State private var showTrailer: Bool = false
    @State private var selectedTab: DetailTab = .overview
    @Environment(\.colorScheme) var colorScheme
    
    // 넷플릭스 스타일 색상
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    private let secondaryTextColor = Color.gray
    
    // 임시 장르 데이터
    private let tempGenres = ["액션", "모험", "스릴러", "드라마", "SF", "코미디", "로맨스", "판타지", "공포", "애니메이션"]
    
    // 임시 트레일러 URL
    private let tempTrailerURL = URL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                LoadingView()
            } else if let movie = viewModel.movieDetail {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 0) {
                        // 헤더 섹션 (배경 이미지 + 영화 제목 + 버튼)
                        heroSection(movie: movie)
                        
                        // 인포 바 (평점, 연도, 등급)
                        infoBar(movie: movie)
                        
                        // 컨트롤 버튼
                        actionButtons()
                        
                        // 탭 선택기
                        tabSelector()
                        
                        // 선택된 탭에 따른 콘텐츠
                        tabContent(movie: movie)
                    }
                    
                    
                        
                }
            } else if let error = viewModel.error {
                errorView(errorMessage: error)
            }
        }
        .fullScreenCover(isPresented: $showTrailer) {
            TrailerPlayerView(trailerURL: tempTrailerURL)
        }
        .background(backgroundColor)
        .foregroundColor(textColor)
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("CineHive")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(accentColor)
            }
        }
        .onAppear {
            viewModel.fetchMovieDetail(movieId: movieId)
        }
    }
    
    // MARK: - 히어로 섹션 (배경 이미지 + 영화 제목 + 버튼)
    private func heroSection(movie: MovieDetail) -> some View {
        ZStack(alignment: .bottom) {
            // 백드롭 이미지
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .empty:
                    Rectangle().fill(Color.gray.opacity(0.3))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle().fill(Color.gray.opacity(0.3))
                @unknown default:
                    Rectangle().fill(Color.gray.opacity(0.3))
                }
            }
            .frame(height: 500)
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        backgroundColor,
                        backgroundColor.opacity(0.0),
                        backgroundColor.opacity(0.5),
                        backgroundColor.opacity(0.8),
                        backgroundColor
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            HStack{
                PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                
                VStack(alignment: .leading, spacing: 16) {
                    // 장르 태그 (임시 데이터)
                    HStack {
                        ForEach(Array(tempGenres.shuffled().prefix(3)), id: \.self) { genre in
                            Text(genre)
                                .font(.system(size: 12))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 4)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(4)
                        }
                    }
                    
                    // 영화 제목
                    Text(movie.title)
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(textColor)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
                    
                    // 시청하기 버튼
                    Button(action: {
                        showTrailer = true
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                            Text("예고편 보기")
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(accentColor)
                        .cornerRadius(4)
                        .foregroundColor(textColor)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
                
            }
            
            
        }
    }
    
    // MARK: - 정보 바 (평점, 연도, 등급)
    private func infoBar(movie: MovieDetail) -> some View {
        HStack(spacing: 16) {
            Spacer()
            // 평점
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", movie.voteAverage))
                    .fontWeight(.semibold)
            }
            
            // 구분선
            Text("•")
                .foregroundColor(secondaryTextColor)
            
            // 개봉 연도
            Text(String(movie.releaseDate.prefix(4)))
            
            // 구분선
            Text("•")
                .foregroundColor(secondaryTextColor)
            
            // 인기도
            Text("\(Int(movie.popularity)) 관심")
            
            // 구분선
            Text("•")
                .foregroundColor(secondaryTextColor)
            
            // 상영 시간 (임시 데이터)
            Text("\(Int.random(in: 90...180))분")
            
            Spacer()
        }
        .font(.system(size: 14))
        .foregroundColor(secondaryTextColor)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor) // 배경색 추가
        
    }
    
    // MARK: - 액션 버튼
    private func actionButtons() -> some View {
        HStack(spacing: 0) {
            Button(action: {}) {
                VStack(spacing: 8) {
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                    Text("내 리스트")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }
            
            Button(action: {}) {
                VStack(spacing: 8) {
                    Image(systemName: "hand.thumbsup")
                        .font(.system(size: 18))
                    Text("평가")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }
            
            Button(action: {}) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 18))
                    Text("공유")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .foregroundColor(textColor)
        .padding(.vertical, 16)
        .background(backgroundColor)
    }
    
    // MARK: - 탭 선택기
    private func tabSelector() -> some View {
        HStack(spacing: 20) {
            ForEach(DetailTab.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 8) {
                        Text(tab.title)
                            .font(.system(size: 16, weight: selectedTab == tab ? .bold : .regular))
                            .foregroundColor(selectedTab == tab ? textColor : secondaryTextColor)
                        
                        Rectangle()
                            .fill(selectedTab == tab ? accentColor : Color.clear)
                            .frame(height: 2)
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
    
    // MARK: - 탭 콘텐츠
    private func tabContent(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            switch selectedTab {
            case .overview:
                overviewSection(movie: movie)
                episodeSection()
                actorsSection(movie: movie)
            case .related:
                relatedMoviesSection()
            case .details:
                detailsSection(movie: movie)
            case .comments:
                commentsSection()
            }
        }
        .padding(.top, 16)
    }
    
    // MARK: - 줄거리 섹션
    private func overviewSection(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(movie.overview)
                .font(.system(size: 15))
                .lineSpacing(6)
                .foregroundColor(textColor.opacity(0.9))
                .lineLimit(isOverviewExpanded ? nil : 3)
                .padding(.horizontal, 16)
                .animation(.easeInOut(duration: 0.2), value: isOverviewExpanded)
            
            if !isOverviewExpanded {
                Button(action: {
                    withAnimation {
                        isOverviewExpanded.toggle()
                    }
                }) {
                    Text("더보기")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(secondaryTextColor)
                        .padding(.horizontal, 16)
                }
            }
            
            Text("감독: \(movie.director.name)")
                .font(.system(size: 14))
                .foregroundColor(secondaryTextColor)
                .padding(.horizontal, 16)
                .padding(.top, 8)
        }
    }
    
    // MARK: - 에피소드 섹션 (영화이므로 비슷한 영상들을 보여줌)
    private func episodeSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("관련 영상")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1...5, id: \.self) { i in
                        Button(action: {
                            showTrailer = true
                        }) {
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 280, height: 160)
                                    .cornerRadius(4)
                                
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 42))
                                    .foregroundColor(textColor.opacity(0.8))
                            }
                            .overlay(
                                VStack(alignment: .leading) {
                                    Spacer()
                                    Text(videoTitles[i-1])
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(textColor)
                                        .padding(8)
                                        .lineLimit(1)
                                }
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(4),
                                alignment: .bottom
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    // MARK: - 출연 배우 섹션
    private func actorsSection(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("출연 배우")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(movie.actors, id: \.id) { actor in
                        VStack(spacing: 8) {
                            if let url = actor.posterURL {
                                AsyncImage(url: url) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Circle()
                                        .fill(Color.gray.opacity(0.2))
                                }
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
                            }
                            
                            Text(actor.name)
                                .font(.system(size: 14))
                                .foregroundColor(textColor)
                                .multilineTextAlignment(.center)
                                .frame(width: 90)
                                .lineLimit(1)
                            
                            Text(actorRoles.randomElement() ?? "배우")
                                .font(.system(size: 12))
                                .foregroundColor(secondaryTextColor)
                                .frame(width: 90)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    // MARK: - 관련 영화 섹션
    private func relatedMoviesSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("비슷한 영화")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 16)
            
            relatedMoviesRow(title: "장르가 비슷한 영화")
            relatedMoviesRow(title: "같은 감독의 영화")
            relatedMoviesRow(title: "팬들이 좋아하는 영화")
        }
    }
    
    // 관련 영화 행
    private func relatedMoviesRow(title: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1...6, id: \.self) { _ in
                        VStack(alignment: .leading, spacing: 6) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 180)
                                .cornerRadius(4)
                            
                            Text(movieTitles.randomElement() ?? "영화 제목")
                                .font(.system(size: 14))
                                .foregroundColor(textColor)
                                .lineLimit(1)
                                .frame(width: 120, alignment: .leading)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                                Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                                    .font(.system(size: 12))
                                    .foregroundColor(secondaryTextColor)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    // MARK: - 상세 정보 섹션
    private func detailsSection(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            // 영화 정보
            VStack(alignment: .leading, spacing: 16) {
                Text("영화 정보")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 12) {
                    detailRow(label: "개봉일", value: movie.releaseDate)
                    detailRow(label: "장르", value: tempGenres.shuffled().prefix(3).joined(separator: ", "))
                    detailRow(label: "국가", value: "미국, 영국") // 임시 데이터
                    detailRow(label: "상영 시간", value: "\(Int.random(in: 90...180))분") // 임시 데이터
                    detailRow(label: "등급", value: ["G", "PG-13", "R", "15세 이상", "12세 이상"].randomElement() ?? "")
                    detailRow(label: "제작사", value: productionCompanies.randomElement() ?? "")
                }
            }
            
            // 기술적 정보
            VStack(alignment: .leading, spacing: 16) {
                Text("기술 정보")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 12) {
                    detailRow(label: "음향", value: ["Dolby Atmos", "Dolby Digital", "DTS:X", "DTS-HD"].randomElement() ?? "")
                    detailRow(label: "화질", value: ["4K UHD", "HDR10+", "Dolby Vision"].randomElement() ?? "")
                    detailRow(label: "자막", value: "한국어, 영어, 일본어, 중국어")
                }
            }
        }
    }
    
    // 상세 정보 행
    private func detailRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(secondaryTextColor)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - 코멘트 섹션
    private func commentsSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("시청자 리뷰")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Button(action: {}) {
                    Text("리뷰 작성")
                        .font(.system(size: 14))
                        .foregroundColor(accentColor)
                }
            }
            .padding(.horizontal, 16)
            
            ForEach(1...5, id: \.self) { i in
                commentItem(
                    username: usernames.randomElement() ?? "User",
                    rating: Double.random(in: 3.0...5.0),
                    comment: reviews.randomElement() ?? "좋은 영화였습니다."
                )
            }
        }
    }
    
    // 코멘트 아이템
    private func commentItem(username: String, rating: Double, comment: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(secondaryTextColor)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(username)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(textColor)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= Int(rating) ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundColor(i <= Int(rating) ? .yellow : secondaryTextColor)
                        }
                        
                        Text("• \(Int.random(in: 1...12))일 전")
                            .font(.system(size: 12))
                            .foregroundColor(secondaryTextColor)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "hand.thumbsup")
                        .font(.system(size: 14))
                        .foregroundColor(secondaryTextColor)
                }
            }
            
            Text(comment)
                .font(.system(size: 15))
                .lineSpacing(4)
                .foregroundColor(textColor.opacity(0.9))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
    
    // MARK: - 오류 화면
    private func errorView(errorMessage: String) -> some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(secondaryTextColor)
                .padding()
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(secondaryTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            
            Button(action: {
                viewModel.fetchMovieDetail(movieId: movieId)
            }) {
                Text("다시 시도")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(accentColor)
                    .cornerRadius(4)
                    .padding(.top, 24)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
    
    // MARK: - 예고편 플레이어 뷰
    struct TrailerPlayerView: View {
        let trailerURL: URL
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                VideoPlayer(player: AVPlayer(url: trailerURL))
                    .edgesIgnoringSafeArea(.all)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .padding()
                }
            }
        }
    }
    
    // MARK: - 탭 열거형
    enum DetailTab: CaseIterable {
        case overview
        case related
        case details
        case comments
        
        var title: String {
            switch self {
            case .overview: return "개요"
            case .related: return "비슷한 콘텐츠"
            case .details: return "상세 정보"
            case .comments: return "리뷰"
            }
        }
    }
    
    // MARK: - 임시 데이터
    private let movieTitles = [
        "어벤져스: 엔드게임", "인셉션", "인터스텔라", "기생충", "다크 나이트",
        "매트릭스", "타이타닉", "스타워즈", "아바타", "조커"
    ]
    
    private let videoTitles = [
        "공식 예고편", "티저 영상", "메이킹 필름", "배우 인터뷰", "삭제된 장면"
    ]
    
    private let actorRoles = [
        "주연", "조연", "특별출연", "악역", "감독"
    ]
    
    private let productionCompanies = [
        "워너 브라더스", "유니버설 픽처스", "디즈니", "파라마운트 픽처스", "20세기 폭스", "소니 픽처스"
    ]
    
    private let usernames = [
        "영화광", "시네필", "무비로버", "필름버프", "평론가지망생", "팝콘매니아", "씨네마스터"
    ]
    
    private let reviews = [
        "정말 재미있게 봤습니다. 스토리, 연기, 연출 모두 완벽했습니다.",
        "기대 이상이었어요. 배우들의 연기가 특히 인상적이었습니다.",
        "영상미가 아름다운 작품입니다. 음악과의 조화도 훌륭했어요.",
        "스토리는 좀 식상했지만 연출이 좋아서 재미있게 봤습니다.",
        "배우들의 연기가 너무 좋았습니다. 특히 주연 배우의 연기가 인상적이었어요.",
        "제가 본 영화 중에 올해 최고의 영화입니다. 강력 추천합니다!",
        "기대했던 것보다는 조금 아쉬웠지만 충분히 즐길만한 영화였습니다."
    ]
}


#Preview {
    NavigationView {
        DetailView2(movieId: 13)
    }
}
