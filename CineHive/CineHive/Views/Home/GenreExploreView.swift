//
//  GenreExploreView.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

// 장르별 탐색 섹션 컴포넌트
struct GenreExploreView: View {
    @State private var selectedGenre: String? = nil
    
    private let genres = ["액션", "모험", "코미디", "드라마", "SF", "판타지", "공포", "로맨스", "스릴러", "애니메이션"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("장르별 탐색")
                .font(.title3)
                .bold()
                .foregroundColor(CHColors.textColor)
                .padding(.leading, 15)
                .padding(.top, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    // 주요 장르 선택 버튼
                    ForEach(genres, id: \.self) { genre in
                        genreButton(genre: genre, isSelected: selectedGenre == genre) {
                            // 장르 선택 시 액션
                            withAnimation {
                                selectedGenre = selectedGenre == genre ? nil : genre
                            }
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 5)
            }
            
            // 선택된 장르가 있을 경우 장르별 영화 표시
            if let genre = selectedGenre {
                genreMoviesPreview(genre: genre)
            }
        }
        .padding(.top, 30)
    }
    
    // 장르별 영화 미리보기 (선택된 장르가 있을 경우)
    private func genreMoviesPreview(genre: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(genre) 영화")
                .font(.headline)
                .foregroundColor(CHColors.textColor)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    // 임시 데이터 - 실제로는 API로 장르별 영화 가져와야 함
                    ForEach(1...8, id: \.self) { index in
                        NavigationLink(destination: DetailView(movieId: index)) {
                            genreMovieCard(title: "\(genre) 영화 \(index)", rating: Double.random(in: 7.0...9.5))
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
        }
        .transition(.opacity)
    }
    
    // 장르 영화 카드
    private func genreMovieCard(title: String, rating: Double) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            // 임시 포스터 이미지
            ZStack {
                Rectangle()
                    .fill(CHColors.cardBackground)
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
                
                Image(systemName: "film")
                    .font(.system(size: 30))
                    .foregroundColor(CHColors.secondaryColor)
            }
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(CHColors.textColor)
                .lineLimit(1)
                .frame(width: 120, alignment: .leading)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(CHColors.starColor)
                    .font(.system(size: 12))
                
                Text(String(format: "%.1f", rating))
                    .font(.system(size: 12))
                    .foregroundColor(CHColors.secondaryColor)
            }
        }
    }
    
    // 장르 버튼
    private func genreButton(genre: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(genre)
                .font(.system(size: 15, weight: isSelected ? .semibold : .regular))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? CHColors.primaryColor : Color.gray.opacity(0.3))
                .foregroundColor(CHColors.textColor)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: isSelected ? 0 : 1)
                )
                .shadow(color: isSelected ? CHColors.primaryColor.opacity(0.5) : Color.clear, radius: 5)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

#Preview {
    GenreExploreView()
        .background(CHColors.backgroundColor)
}
