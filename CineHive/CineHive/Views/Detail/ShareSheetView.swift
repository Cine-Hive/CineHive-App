//
//  ShareSheetView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct ShareSheetView: View {
    let movie: MovieDetail
    let onDismiss: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 헤더
            HStack {
                Text("영화 공유하기")
                    .font(.headline)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title3)
                }
            }
            
            // 영화 정보 미리보기
            MoviePreviewCard(movie: movie)
            
            // 공유 옵션 버튼들
            Text("공유 방법")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 8)
            
            SharingOptionsGrid(movie: movie, onDismiss: onDismiss)
            
            Spacer()
        }
        .padding()
        .frame(height: 350)
    }
}

// MARK: - 서브 컴포넌트

struct MoviePreviewCard: View {
    let movie: MovieDetail
    
    var body: some View {
        HStack(spacing: 16) {
            // 포스터 이미지
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.white)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 80, height: 120)
                .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 120)
                    .cornerRadius(8)
            }
            
            // 영화 정보
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                
                if !movie.releaseDate.isEmpty {
                    Text("개봉: \(movie.releaseDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                    Text(String(format: "%.1f", movie.voteAverage))
                        .font(.system(size: 14))
                }
                
                if !movie.genres.isEmpty {
                    Text(movie.genres.prefix(3).map { $0.name }.joined(separator: ", "))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

struct SharingOptionsGrid: View {
    let movie: MovieDetail
    let onDismiss: () -> Void
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            ShareOptionButton(title: "메시지", icon: "message.fill", color: .green)
            ShareOptionButton(title: "카카오톡", icon: "bubble.left.fill", color: .yellow)
            ShareOptionButton(title: "URL 복사", icon: "doc.on.doc", color: .blue) {
                UIPasteboard.general.string = "https://cinehive.app/movies/\(movie.id)"
                
                // 복사 성공 표시
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
                onDismiss()
            }
            ShareOptionButton(title: "인스타그램", icon: "camera.fill", color: .purple)
            ShareOptionButton(title: "트위터", icon: "bird.fill", color: .blue)
            ShareOptionButton(title: "더보기", icon: "ellipsis", color: .gray)
        }
        .padding(.top, 10)
    }
}

struct ShareOptionButton: View {
    let title: String
    let icon: String
    let color: Color
    var action: (() -> Void)?
    
    var body: some View {
        Button(action: { action?() }) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(color.opacity(0.2))
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(color)
                }
                
                Text(title)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    let dummyMovie = MovieDetail.dummy
    
    return ShareSheetView(movie: dummyMovie, onDismiss: {})
}
