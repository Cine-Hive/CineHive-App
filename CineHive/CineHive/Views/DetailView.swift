//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct DetailView: View {
    let movieId: Int
    @State private var viewModel: MovieViewModel = MovieViewModel()
    @State private var isExpanded: Bool = false // 더보기 버튼 펼침 유무
    
    var body: some View {
        ScrollView {
            if let movie = viewModel.movieDetail {
                VStack(alignment: .leading, spacing: 20) {
                    // MARK: - 헤더 영역 (배경 이미지)
                    ZStack(alignment: .bottom) {
                        // 배경 이미지와 그라데이션 오버레이
                        // 나중에 백드롭이미지나, 예고편 넣으면 좋을듯함
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
                        
                        // 영화 제목 (배경 이미지 하단에 표시)
                        Text(movie.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 130) // 포스터와 겹치지 않도록 왼쪽 여백 추가
                    }
                    
                    // MARK: - 영화 정보 섹션
                    HStack(alignment: .top, spacing: 20) {
                        // 포스터 (그림자와 둥근 모서리 적용)
                        PosterView(posterURL: movie.posterURL)
                            .frame(width: 120, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .shadow(radius: 4)
                            .offset(y: -40) // 포스터를 위로 끌어올려 배경 이미지와 겹치게 함
                        
                        // 영화 메타데이터
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
                    
                    // MARK: - 줄거리 섹션
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
                    .offset(y: -30)
                    
                    // MARK: - 출연 배우 섹션
                    if !movie.actors.isEmpty {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("출연 배우")
                                .font(.headline)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 5)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(movie.actors, id: \.id) { actor in
                                        VStack(spacing: 8) {
                                            // 배우 프로필 이미지
                                            Circle()
                                                .fill(Color.gray.opacity(0.2))
                                                .frame(width: 70, height: 70)
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                                )
                                            
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
                    }
                }
                
            } else if viewModel.isLoading {
                // MARK: - 로딩 화면
                VStack {
                    Spacer()
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                    Text("로딩 중...")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 100)
                
            } else {
                // MARK: - 오류 화면
                VStack {
                    Spacer()
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .padding()
                    Text("영화 정보를 불러오지 못했습니다.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, 100)
            }
        }
        .navigationTitle("영화 상세 정보")
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top) // 배경 이미지를 상단 가장자리까지 확장
        .onAppear {
            viewModel.fetchMovieDetail(movieId: movieId)
        }
    }
}

#Preview {
    DetailView(movieId: 950396)
}
