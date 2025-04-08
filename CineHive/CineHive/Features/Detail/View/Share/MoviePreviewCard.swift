//
//  MoviePreviewCard.swift
//  CineHive
//
//  Created by 이종민 on 3/8/25.
//

import SwiftUI

// MARK: - MoviePreviewCard
struct MoviePreviewCard: View {
    let movie: MovieDetail
    
    private struct Theme {
        static let cardBackground = Color(white: 0.15)
        static let text = Color.white
        static let secondaryText = Color.gray
        static let accent = Color.red
        static let starColor = Color.yellow
    }
    
    var body: some View {
        HStack(spacing: 16) {
            // 포스터 이미지
            PosterView(posterURL: movie.posterURL, width: 80, height: 120)
            // 영화 정보
            movieInfo
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.cardBackground)
        .cornerRadius(12)
    }
    
    private var movieInfo: some View {
            VStack(alignment: .leading, spacing: 6) {
                Text(movie.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Theme.text)
                    .lineLimit(2)
                
                if !movie.releaseDate.isEmpty {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 12))
                            .foregroundColor(Theme.secondaryText)
                        
                        Text(movie.releaseDate)
                            .font(.subheadline)
                            .foregroundColor(Theme.secondaryText)
                    }
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(Theme.starColor)
                        .font(.system(size: 12))
                    
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.system(size: 14))
                        .foregroundColor(Theme.text)
                    
                    Text("/ 10")
                        .font(.system(size: 12))
                        .foregroundColor(Theme.secondaryText)
                }
                
                if !movie.genres.isEmpty {
                    Text(movie.genres.prefix(3).map { $0.name }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(Theme.secondaryText)
                        .lineLimit(1)
                }
            }
            .padding(.trailing, 8)
        }
}

#Preview {
    MoviePreviewCard(movie: MovieDetail.dummy)
}
