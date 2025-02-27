//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct DetailView: View {
    let movieId: Int
    @State private var viewModel = MovieViewModel()
    @State private var isExpanded: Bool = false // 더보기 버튼 펼침 유무
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                loadingView
            } else if let movie = viewModel.movieDetail {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        headerSection(movie: movie)
                        movieInfoSection(movie: movie)
                        ratingPopularitySection(movie: movie) // 평점 및 인기 추가
                        overviewSection(movie: movie)
                        if !movie.actors.isEmpty {
                            actorsSection(movie: movie)
                        }
                    }
                }
            } else if let error = viewModel.error {
                errorView(errorMessage: error)
            }
        }
        .navigationTitle("영화 상세 정보")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
        .onAppear {
            viewModel.fetchMovieDetail(movieId: movieId)
        }
    }
    
    // MARK: - 헤더 (포스터 + 영화 제목)
    private func headerSection(movie: MovieDetail) -> some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 220)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0)]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            
            Text(movie.title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 130) // 포스터와 겹치지 않도록 왼쪽 여백 추가
        }
    }
    
    // MARK: - 영화 정보 섹션 (포스터 + 개봉일 + 감독)
    private func movieInfoSection(movie: MovieDetail) -> some View {
        HStack(alignment: .top, spacing: 20) {
            PosterView(posterURL: movie.posterURL)
                .shadow(radius: 4)
                .offset(y: -40)
            
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("감독")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(movie.director.name)
                        .font(.subheadline)
                }
                
                Divider()
                
                HStack {
                    Text("개봉일")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(movie.releaseDate)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 8)
        }
        .padding(.horizontal, 16)
    }
    
    // MARK: - 평점 & 인기도 섹션
    private func ratingPopularitySection(movie: MovieDetail) -> some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", movie.voteAverage))
                    .font(.subheadline)
                    .fontWeight(.bold)
            }
            
            HStack {
                Image(systemName: "flame.fill")
                    .foregroundColor(.red)
                Text("\(Int(movie.popularity))명 관심")
                    .font(.subheadline)
            }
        }
        .offset(y: -40)
        .padding(.horizontal, 16)
    }
    
    // MARK: - 줄거리 섹션
    private func overviewSection(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("줄거리")
                .font(.headline)
                .padding(.bottom, 5)
                .padding(.horizontal, 16)
            
            Text(movie.overview)
                .font(.body)
                .lineSpacing(8)
                .lineLimit(isExpanded ? nil : 3)
                .padding(.horizontal, 16)
                .animation(.easeInOut(duration: 0.2), value: isExpanded)
            
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(isExpanded ? "접기" : "더보기")
                        .font(.subheadline)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                }
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
                .fontWeight(.semibold)
                .padding(.top, 5)
            }
        }
        .offset(y: -40)
    }
    
    // MARK: - 출연 배우 섹션
    private func actorsSection(movie: MovieDetail) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("출연 배우")
                .font(.headline)
                .padding(.horizontal, 16)
                .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
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
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 70, height: 70)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            
                            Text(actor.name)
                                .font(.system(size: 14))
                                .multilineTextAlignment(.center)
                                .frame(width: 80)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .offset(y: -40)
    }
    
    // MARK: - 로딩 화면
    private var loadingView: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            Text("로딩 중...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    
    // MARK: - 오류 화면
    private func errorView(errorMessage: String) -> some View {
        VStack {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.gray)
                .padding()
            Text(errorMessage) // 오류 메시지 표시
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    DetailView(movieId: 950396)
}
