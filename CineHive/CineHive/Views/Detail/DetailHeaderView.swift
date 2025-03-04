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
            
            HStack {
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
                    // 예고편 보기 버튼
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
            .padding(.bottom, 20)
        }
    }
}
