//
//  GenreRowView.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct GenreRowView: View {
    let genres = [
        Genre(id: 28, name: "액션"),
        Genre(id: 12, name: "모험"),
        Genre(id: 16, name: "애니메이션"),
        Genre(id: 35, name: "코미디"),
        Genre(id: 80, name: "범죄"),
        Genre(id: 99, name: "다큐멘터리"),
        Genre(id: 18, name: "드라마"),
        Genre(id: 10751, name: "가족"),
        Genre(id: 14, name: "판타지"),
        Genre(id: 36, name: "역사"),
        Genre(id: 27, name: "공포"),
        Genre(id: 10402, name: "음악"),
        Genre(id: 9648, name: "미스터리"),
        Genre(id: 10749, name: "로맨스"),
        Genre(id: 878, name: "SF"),
        Genre(id: 53, name: "스릴러"),
        Genre(id: 10752, name: "전쟁"),
        Genre(id: 37, name: "서부")
    ]
    
    @State private var selectedGenre: Genre? = nil
    @Binding var viewModel: MovieViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("장르별 탐색")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .padding(.leading, 15)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(genres.prefix(10)) { genre in
                        GenreButton(
                            genre: genre,
                            isSelected: selectedGenre?.id == genre.id,
                            action: {
                                withAnimation(.spring(response: 0.3)) {
                                    selectedGenre = selectedGenre?.id == genre.id ? nil : genre
                                }
                                // Here you would typically filter movies by genre
                            }
                        )
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
            }
            
            // Show movies for selected genre
            if let genre = selectedGenre {
                VStack(alignment: .leading) {
                    Text("\(genre.name) 영화")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.leading, 15)
                        .padding(.top, 10)
                    
                    // Filtered movie list
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 15) {
                            ForEach(1...8, id: \.self) { index in
                                NavigationLink(destination: DetailView(movieId: genre.id + index)) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        // Generate a random poster URL for this example
                                        PosterView(
                                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500/\(["9Gtg2DzBhmYamXBS1hKAhiwbBKS", "t6HIqrRAclMzcQm5ynoNekJtgxY", "7WsyChQLEftFiDOVTGkv3hFpyyt", "vZloFAK7NmvMCKE7XmjxvC5wekX", "qNBAXBIQlnOThrVvA6mA2B5ggV6"].randomElement()!).jpg"),
                                            width: 120,
                                            height: 180
                                        )
                                        
                                        Text("\(genre.name) \(index)")
                                            .font(.system(size: 14))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                            .frame(width: 120, alignment: .leading)
                                        
                                        HStack {
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .font(.system(size: 12))
                                            Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                                                .font(.system(size: 12))
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.leading, 15)
                        .padding(.trailing, 15)
                        .padding(.vertical, 10)
                    }
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
    }
}

struct GenreButton: View {
    let genre: Genre
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(genre.name)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.red : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: isSelected ? 0 : 1)
                )
                .shadow(color: isSelected ? Color.red.opacity(0.5) : Color.clear, radius: 5)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
