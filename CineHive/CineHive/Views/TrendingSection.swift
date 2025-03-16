//
//  TrendingSection.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct TrendingSection: View {
    let viewModel: MovieViewModel
    
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title with badge
            HStack {
                Text("인기 급상승 콘텐츠")
                    .font(.title3)
                    .bold()
                    .foregroundColor(textColor)
                
                Spacer()
                
                Text("더보기")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
            
            // Content
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 15) {
                    ForEach(1...10, id: \.self) { index in
                        NavigationLink(destination: DetailView(movieId: index * 100)) {
                            TrendingItemView(rank: index)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 10)
            }
        }
        .padding(.top, 30)
    }
}

struct TrendingItemView: View {
    let rank: Int
    
    private let textColor = Color.white
    private let accentColor = Color.red
    private let backgroundColor = Color.black
    
    // Random poster image from a set of paths
    private var posterPath: String {
        let paths = [
            "9Gtg2DzBhmYamXBS1hKAhiwbBKS",
            "t6HIqrRAclMzcQm5ynoNekJtgxY",
            "7WsyChQLEftFiDOVTGkv3hFpyyt",
            "vZloFAK7NmvMCKE7XmjxvC5wekX",
            "qNBAXBIQlnOThrVvA6mA2B5ggV6"
        ]
        return paths[rank % paths.count]
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Base container
            HStack(spacing: 0) {
                // Ranking number
                ZStack {
                    Text("\(rank)")
                        .font(.system(size: 90, weight: .bold))
                        .foregroundColor(.white.opacity(0.1))
                        .offset(x: -10)
                    
                    Text("\(rank)")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(accentColor)
                        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 2)
                }
                .frame(width: 60)
                .padding(.leading, 10)
                
                // Poster image
                PosterView(
                    posterURL: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath).jpg"),
                    width: 120,
                    height: 180
                )
                .cornerRadius(8)
                .shadow(radius: 5)
                .padding(.trailing, 10)
                .padding(.vertical, 10)
            }
            .frame(width: 190, height: 200)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(10)
            
            // Play button overlay
            Button {
                // Play action
            } label: {
                Image(systemName: "play.fill")
                    .font(.system(size: 22))
                    .foregroundColor(backgroundColor)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.5), radius: 4)
            }
            .offset(x: 150, y: -10)
            .buttonStyle(ScaleButtonStyle())
            
            // Content metadata
            VStack(alignment: .leading, spacing: 5) {
                Text("콘텐츠 제목 \(rank)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(textColor)
                    .lineLimit(1)
                
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    
                    Text(String(format: "%.1f", 8.0 + Double(rank % 20) / 10))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 70)
            .padding(.bottom, 10)
        }
        .contentShape(Rectangle())
    }
}
