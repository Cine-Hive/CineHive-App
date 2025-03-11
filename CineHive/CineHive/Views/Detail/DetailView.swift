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
    @State private var viewModel: DetailViewModel
    @Environment(\.dismiss) private var dismiss

    // 넷플릭스 스타일 색상 상수
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    private let secondaryTextColor = Color.gray
    
    // 임시 데이터 (추후 별도 파일로 분리 가능)
    private let tempGenres = ["액션", "모험", "스릴러", "드라마", "SF", "코미디", "로맨스", "판타지", "공포", "애니메이션"]
    
    init(movieId: Int) {
        self.movieId = movieId
        _viewModel = State(wrappedValue: DetailViewModel(movieId: movieId))
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
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
                        
                        Spacer().frame(height: 120)
                        
                        // 정보 바
                        DetailInfoBarView(
                            movie: movie,
                            secondaryTextColor: secondaryTextColor,
                            backgroundColor: backgroundColor
                        )
                        
                        // 액션 버튼
                        DetailActionButtonsView(
                            backgroundColor: backgroundColor,
                            textColor: textColor,
                            movie: movie
                        )
                        
                        // 탭 선택기
                        DetailTabView(
                            selectedTab: $viewModel.selectedTab,
                            accentColor: accentColor,
                            textColor: textColor,
                            secondaryTextColor: secondaryTextColor
                        )
                        
                        // 탭 콘텐츠
                        DetailTabContentView(
                            movie: movie,
                            selectedTab: viewModel.selectedTab,
                            isOverviewExpanded: viewModel.isOverviewExpanded
                        )
                    }
                } else if let error = viewModel.error {
                    DetailErrorView(
                        errorMessage: error,
                        backgroundColor: backgroundColor,
                        textColor: textColor,
                        accentColor: accentColor
                    ) {
                        viewModel.fetchMovieDetail()
                    }
                }
            }
            .background(backgroundColor)
            .foregroundColor(textColor)
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            .statusBar(hidden: true)
            .toolbar(.hidden, for: .tabBar)
            
            BackButtonView(action: { dismiss() }, color: textColor)
        }
        .fullScreenCover(isPresented: $viewModel.showFullScreenVideo) {
            if let videoID = viewModel.selectedVideoID {
                FullScreenVideoView(videoID: videoID, onClose: {
                    viewModel.showFullScreenVideo = false
                })
            } else {
                VideoErrorView {
                    viewModel.showFullScreenVideo = false
                }
            }
        }
        .onAppear {
            viewModel.fetchMovieDetail()
        }
    }
}



#Preview {
    NavigationView {
        DetailView(movieId: 950396)
    }
}
