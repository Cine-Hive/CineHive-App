//
//  OTTPopularContentsView.swift
//  CineHive
//
//  Created by 이종민 on 3/22/25.
//

import SwiftUI

struct OTTPopularContentsView: View {
    let movies: [Movie]
    @Binding var selectedOTT: OTT
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "OTT별 인기 콘텐츠", actionTitle: "더보기")
            
            // OTT 선택 버튼
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(OTT.allCases, id: \.self) { ott in
                        ottPlatformButton(ott: ott, isSelected: selectedOTT == ott)
                            .onTapGesture {
                                withAnimation(.spring(duration: 0.3)) {
                                    selectedOTT = ott
                                }
                            }
                    }
                }
            }
            
            // 선택된 OTT의 콘텐츠
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(movies.prefix(8), id: \.id) { movie in
                        NavigationLink(destination: DetailView(movieId: movie.id)) {
                            ottContentCard(movie: movie)
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.horizontal, 15)
        .padding(.top, 30)
    }
    
    // OTT 플랫폼 버튼
    private func ottPlatformButton(ott: OTT, isSelected: Bool) -> some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(isSelected ? ott.color.opacity(0.3) : Color.gray.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: ott.iconName)
                    .foregroundColor(isSelected ? ott.color : CHColors.secondaryColor)
                    .font(.system(size: 24))
            }
            
            Text(ott.name)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? CHColors.textColor : CHColors.secondaryColor)
        }
    }
    
    // OTT 콘텐츠 카드
    private func ottContentCard(movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // 포스터
            ZStack(alignment: .topTrailing) {
                PosterView(posterURL: movie.posterURL, width: 130, height: 190)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 3)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(selectedOTT.color.opacity(0.3), lineWidth: 1)
                    )
                
                // OTT 플랫폼 뱃지
                HStack(spacing: 4) {
                    Image(systemName: selectedOTT.iconName)
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                    
                    Text(selectedOTT.shortName)
                        .font(.system(size: 9, weight: .medium))
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(selectedOTT.color)
                .clipShape(Capsule())
                .padding(8)
            }
            
            // 콘텐츠 정보
            VStack(alignment: .leading, spacing: 6) {
                // 제목
                Text("영화 제목")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack(spacing: 8) {
                    // 평점
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(CHColors.starColor)
                            .font(.system(size: 12))
                        
                        Text(String(format: "%.1f", 8.0 + Double(movie.id % 20) / 10))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(CHColors.textColor)
                    }
                    // 구분점
                    Text("•")
                        .font(.system(size: 10))
                        .foregroundColor(CHColors.secondaryColor)
                    // 순위
                    Text("인기 \(movie.id % 10 + 1)위")
                        .font(.system(size: 11))
                        .foregroundColor(CHColors.secondaryColor)
                }
            }
            .padding(.horizontal, 2)
        }
        .frame(width: 130)
        .padding(.bottom, 5)
        .contentShape(Rectangle()) // 전체 영역 탭 가능
    }
}

#Preview {
    @Previewable @State var selectedOTT: OTT = .netflix
    OTTPopularContentsView(movies: Movie.dummyMovies, selectedOTT: $selectedOTT)
        .background(CHColors.backgroundColor)
}
