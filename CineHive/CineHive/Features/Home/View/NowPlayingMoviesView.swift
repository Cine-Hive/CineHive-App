//
//  NowPlayingMoviesView.swift
//  CineHive
//
//  Created by 이종민 on 4/7/25.
//

import SwiftUI

struct NowPlayingMoviesView: View {
    @State private var viewModel = NowPlayingMoviesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SectionHeader(title: "현재 상영작", actionTitle: "더보기")
            
            if viewModel.isLoading {
                LoadingView()
            } else if !viewModel.movies.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.movies.prefix(10), id: \.id) { movie in
                            NavigationLink(destination: DetailView(movieId: movie.id)) {
                                modernMovieTicket(movie: movie)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(height: 380)
            } else {
                Text("영화를 불러올 수 없습니다.")
                    .foregroundColor(CHColors.gray)
                    .padding()
            }
        }
        .padding(.top, 30)
        .padding(.horizontal, 15)
        .task {
            await viewModel.fetchNowPlayingMovies()
        }
    }
    
    // 모던한 티켓 디자인
    private func modernMovieTicket(movie: Movie) -> some View {
        ZStack {
            // 티켓 배경 (고급스러운 그라데이션)
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.black.opacity(0.6),
                            CHColors.cardBackground.opacity(0.85)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay(
                    // 미묘한 질감 패턴
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.white.opacity(0.05),
                                    Color.white.opacity(0.02)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .frame(width: 180, height: 360) // 티켓 전체 높이 증가
                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
            
            // 티켓 캡슐 노치 (위)
            Capsule()
                .fill(Color.black.opacity(0.2))
                .frame(width: 40, height: 5)
                .offset(y: -177.5) // 노치 위치 조정
            
            // 티켓 캡슐 노치 (아래)
            Capsule()
                .fill(Color.black.opacity(0.2))
                .frame(width: 40, height: 5)
                .offset(y: 177.5) // 노치 위치 조정
            
            // 티켓 내용
            VStack(spacing: 0) {
                // 상단 - 포스터와 개봉 정보
                ZStack(alignment: .bottomLeading) {
                    // 포스터
                    PosterView(posterURL: movie.posterURL, width: 180, height: 270) // 포스터 높이 270으로 증가
                        .cornerRadius(0)
                        .cornerRadius(16, corners: [.topLeft, .topRight])
                        .overlay(
                            // 포스터 상단 그라데이션 오버레이
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.black.opacity(0.7),
                                    Color.black.opacity(0.1),
                                    Color.clear
                                ]),
                                startPoint: .top,
                                endPoint: .center
                            )
                            .cornerRadius(16, corners: [.topLeft, .topRight])
                        )
                    
                    // 개봉일 배지
                    Text(viewModel.getDaysFromRelease(for: movie))
                        .font(.system(size: 10, weight: .bold))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(
                            // 배지 그라데이션
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    CHColors.primaryColor.opacity(0.9),
                                    CHColors.primaryColor.opacity(0.7)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(6)
                        .shadow(color: Color.black.opacity(0.2), radius: 3, x: 0, y: 2)
                        .padding(12)
                }
                
                // 점선 분리선
                HStack(spacing: 3) {
                    ForEach(0..<30, id: \.self) { i in
                        Circle()
                            .fill(
                                // 점선 그라데이션
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.gray.opacity(0.4),
                                        Color.gray.opacity(0.2)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 2.5, height: 2.5)
                    }
                }
                .padding(.vertical, 4)
                .background(Color.black.opacity(0.15))
                
                // 하단 - 영화 정보
                VStack(alignment: .leading, spacing: 10) {
                    // NOW SHOWING 티켓 느낌
                    HStack {
                        Text("NOW SHOWING")
                            .font(.system(size: 9, weight: .bold))
                            .kerning(1)
                            .foregroundColor(CHColors.primaryColor.opacity(0.8))

                        Spacer()
                        
                        // 연도 정보
                        Text(MovieFormatter.extractMovieYear(from: movie.releaseDate))
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(CHColors.secondaryColor)
                    }
                    
                    // 제목
                    Text(viewModel.formatTitle(movie.title))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(CHColors.textColor)
                        .lineLimit(1)
                    
                    // 하단 정보
                    HStack {
                        // 평점
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .foregroundColor(CHColors.starColor)
                                .font(.system(size: 10))
                            
                            Text(viewModel.generateRating(for: movie))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(CHColors.textColor)
                        }
                        
                        Spacer()
                        
                        // 장르
                        Text(viewModel.formatGenres(for: movie))
                            .font(.system(size: 10))
                            .foregroundColor(CHColors.secondaryColor)
                            .lineLimit(1)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
            }
            .frame(width: 180, height: 360)
            .clipShape(
                // 티켓 모양 클립
                RoundedRectangle(cornerRadius: 16)
            )
        }
    }
}

// 특정 모서리만 둥글게 만드는 확장
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    NowPlayingMoviesView()
        .background(CHColors.backgroundColor)
}
