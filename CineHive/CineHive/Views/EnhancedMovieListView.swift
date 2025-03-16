//
//  EnhancedMovieListView.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct EnhancedMovieListView: View {
    let movies: [Movie]
    let movieType: MovieListType
    @State var viewModel: MovieViewModel
    
    // Netflix style colors
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    @State private var hoveredIndex: Int? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(movies.indices, id: \.self) { index in
                    let movie = movies[index]
                    NavigationLink(destination: DetailView(movieId: movie.id)) {
                        MovieCard(
                            movie: movie,
                            isHovered: hoveredIndex == index,
                            onHover: { isHovered in
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    hoveredIndex = isHovered ? index : nil
                                }
                            }
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .padding(.vertical, 10)
        }
    }
}

struct MovieCard: View {
    let movie: Movie
    let isHovered: Bool
    let onHover: (Bool) -> Void
    
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Poster with hover effect
            ZStack(alignment: .center) {
                PosterView(
                    posterURL: movie.posterURL,
                    width: isHovered ? 130 : 120,
                    height: isHovered ? 195 : 180
                )
                .cornerRadius(8)
                .shadow(color: isHovered ? .white.opacity(0.3) : .black.opacity(0.5), radius: isHovered ? 8 : 4)
                
                // Play button overlay that appears on hover
                if isHovered {
                    Button(action: {
                        // Play action
                        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                        impactFeedback.impactOccurred()
                    }) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.5), radius: 4)
                    }
                    .transition(.scale.combined(with: .opacity))
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .frame(width: isHovered ? 130 : 120, height: isHovered ? 195 : 180)
            .onTapGesture {} // This makes the view tappable without actions
            .onLongPressGesture(minimumDuration: 0.01, maximumDistance: 0) { pressed in
                onHover(pressed)
            } perform: {}
            
            // Title
            Text("영화 제목")
                .font(.system(size: 14))
                .foregroundColor(textColor)
                .lineLimit(1)
                .frame(width: 120, alignment: .leading)
            
            // Rating
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.system(size: 12))
                Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                    .font(.system(size: 12))
                    .foregroundColor(secondaryColor)
            }
        }
        .scaleEffect(isHovered ? 1.05 : 1.0)
        .zIndex(isHovered ? 1 : 0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isHovered)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .opacity(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// Extension to enable hover effect in SwiftUI
extension View {
    func onHover(perform action: @escaping (Bool) -> Void) -> some View {
        self
            .onTapGesture {} // This makes the view tappable without actions
            .onLongPressGesture(minimumDuration: 0.01, maximumDistance: 0, pressing: { pressing in
                action(pressing)
            }, perform: {})
    }
}
