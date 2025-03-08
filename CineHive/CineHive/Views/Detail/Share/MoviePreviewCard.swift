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
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Theme.cardBackground)
        .cornerRadius(12)
    }
}

#Preview {
    MoviePreviewCard(movie: MovieDetail.dummy)
}
