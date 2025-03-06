//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

enum DetailTab: CaseIterable {
    case overview, related, details, comments
    
    var title: String {
        switch self {
        case .overview: return "개요"
        case .related:  return "비슷한 콘텐츠"
        case .details:  return "상세 정보"
        case .comments: return "리뷰"
        }
    }
}

struct DetailView: View {
    let movieId: Int
    @State private var viewModel = MovieViewModel()
    @State private var isOverviewExpanded: Bool = false
    @State private var selectedTab: DetailTab = .overview
    
    // 넷플릭스 스타일 색상
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    private let secondaryTextColor = Color.gray
    
    // 임시 데이터 (추후 별도 파일로 분리 가능: DetailConstants.swift)
    private let tempGenres = ["액션", "모험", "스릴러", "드라마", "SF", "코미디", "로맨스", "판타지", "공포", "애니메이션"]
    
    var body: some View {
        ZStack {
            ScrollView {
                if viewModel.isLoading {
                    LoadingView()
                } else if let movie = viewModel.movieDetail {
                    VStack(alignment: .leading, spacing: 0) {
                        // 헤더 섹션
                        DetailHeaderView(
                            movie: movie,
                            backgroundColor: backgroundColor,
                            textColor: textColor,
                            accentColor: accentColor,
                            tempGenres: tempGenres
                        )
                        // 정보 바
                        DetailInfoBarView(
                            movie: movie,
                            secondaryTextColor: secondaryTextColor,
                            backgroundColor: backgroundColor
                        )
                        // 액션 버튼
                        DetailActionButtonsView(
                            backgroundColor: backgroundColor,
                            textColor: textColor
                        )
                        // 탭 선택기
                        DetailTabView(
                            selectedTab: $selectedTab,
                            accentColor: accentColor,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor
                        )
                        // 탭 콘텐츠
                        DetailTabContentView(
                            movie: movie,
                            selectedTab: selectedTab,
                            isOverviewExpanded: isOverviewExpanded
                        )
                    }
                } else if let error = viewModel.error {
                    DetailErrorView(
                        errorMessage: error,
                        backgroundColor: backgroundColor,
                        textColor: textColor,
                        accentColor: accentColor
                    ) {
                        viewModel.fetchMovieDetail(movieId: movieId)
                    }
                }
            }
            .background(backgroundColor)
            .foregroundColor(textColor)
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("CineHive")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(textColor)
                }
            }
            .onAppear {
                viewModel.fetchMovieDetail(movieId: movieId)
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(movieId: 950396)
    }
}
