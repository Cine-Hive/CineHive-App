//
//  DetailHeaderView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailHeaderView: View {
    let movie: MovieDetail
    let backgroundColor: Color
    let textColor: Color
    let accentColor: Color
    let tempGenres: [String]
    @State var showTrailer: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack(alignment: .bottom) {
                    // 백드롭 이미지
                    DetailHeaderBackdropView(movie: movie, backgroundColor: backgroundColor)
                    
                    // 장르, 제목, 버튼
                    DetailHeaderContentView(
                        movie: movie,
                        textColor: textColor,
                        accentColor: accentColor,
                        tempGenres: tempGenres,
                        showTrailer: $showTrailer
                    )
                    .padding(.bottom, -140)
                }
            }
        }
    }
}

// MARK: - 백드롭 이미지
struct DetailHeaderBackdropView: View {
    let movie: MovieDetail
    let backgroundColor: Color

    private var overlayGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                backgroundColor.opacity(0.2),
                backgroundColor.opacity(0.0),
                backgroundColor.opacity(0.4),
                backgroundColor.opacity(0.8),
                backgroundColor
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var body: some View {
        BackdropImageView(url: movie.backDropURL)
            .overlay(overlayGradient)
    }
}

// MARK: - 장르, 제목, 버튼
struct DetailHeaderContentView: View {
    let movie: MovieDetail
    let textColor: Color
    let accentColor: Color
    let tempGenres: [String]
    @Binding var showTrailer: Bool
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                // 작은 포스터
                PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                VStack(alignment: .leading, spacing: 16) {
                    // 장르 태그
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
                    // 예고편 보기 버튼 (첫 비디오 있을 경우에만 표시)
                    if let firstVideo = movie.videos?.first {
                        Button(action: {
                            NotificationCenter.default.post(
                                name: Notification.Name("PlayVideo"),
                                object: nil,
                                userInfo: ["videoID": firstVideo.videoKey]
                            )
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
                    } else {
                        // 예고편이 없을 경우 대체 버튼
                        Button(action: {
                            // 영화 정보로 스크롤
                        }) {
                            HStack {
                                Image(systemName: "info.circle")
                                Text("상세 정보")
                                    .fontWeight(.semibold)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(accentColor)
                            .cornerRadius(4)
                            .foregroundColor(textColor)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
            .padding(.bottom, 20)
        }
    }
}



// MARK: - Preview
#Preview {
    DetailHeaderView(
        movie: MovieDetail.dummy,
        backgroundColor: .black,
        textColor: .white,
        accentColor: .red,
        tempGenres: MovieDetail.dummy.genres.map { $0.name }
    )
}
