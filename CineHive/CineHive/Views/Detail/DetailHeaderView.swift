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
    
    var body: some View {
        VStack(spacing: 0) {
            AsyncImage(url: movie.backDropURL) { phase in
                switch phase {
                case .empty:
                    Rectangle().fill(Color.gray.opacity(0.3))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Rectangle().fill(Color.gray.opacity(0.3))
                @unknown default:
                    Rectangle().fill(Color.gray.opacity(0.3))
                }
            }
        }
        .overlay(
            LinearGradient(
                gradient: Gradient(colors: [
                    backgroundColor.opacity(0.3),
                    backgroundColor.opacity(0.0),
                    backgroundColor.opacity(0.5),
                    backgroundColor.opacity(0.8),
                    backgroundColor
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
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
