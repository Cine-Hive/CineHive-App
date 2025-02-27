//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct DetailView: View {
    let movieId: Int // 영화 Id
    @State private var viewModel: MovieViewModel = MovieViewModel()
    @State private var isExpanded: Bool = false
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                if let movie = viewModel.movieDetail {
                    // MARK: - Header: 포스터와 기본 정보
                    HStack(alignment: .top, spacing: 16) {
                        PosterView(posterURL: movie.posterURL)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .font(.title)
                                .bold()
                            
                            Text("감독: \(movie.director.name)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("개봉일: \(movie.releaseDate)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                    }
                    
                    
                    Spacer()
                    
                    // MARK: - 줄거리 (더보기 기능 추가)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("줄거리")
                            .font(.headline)
                        
                        Text(movie.overview)
                            .font(.body)
                            .lineSpacing(4)
                            .lineLimit(isExpanded ? nil : 2) // 2줄까지만 표시 (더보기 전)
                            .animation(.easeInOut, value: isExpanded) // 애니메이션 추가
                        
                        Button(action: {
                            isExpanded.toggle() // 버튼 클릭 시 상태 변경
                        }) {
                            Text(isExpanded ? "접기 ▲" : "더보기 ▼") // 버튼 텍스트 변경
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                    
                    // MARK: - 출연 배우 (배열이 비어있지 않은 경우)
                    if !movie.actors.isEmpty {
                        Divider()
                        
                        Text("출연 배우")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(movie.actors, id: \.id) { actor in
                                    VStack(spacing: 8) {
                                        // 배우 이미지 자리 (실제 이미지가 있다면 AsyncImage 사용 가능)
                                        Circle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 60)
                                        
                                        Text(actor.name)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 70)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    Divider()
                    Spacer()
                    
                    
                } else if viewModel.isLoading {
                    ProgressView("로딩 중..")
                } else {
                    Text("영화 정보를 불러오지 못했습니다.")
                        .foregroundColor(.black)
                        .font(.title2)
                }
            }
            .padding()
            
        }
        .navigationTitle("영화 상세 정보")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchMovieDetail(movieId: movieId)
        }
    }
}


#Preview {
    DetailView(movieId: 950396)
}
