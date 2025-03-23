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
        VStack(alignment: .leading, spacing: 8) {
            // 포스터 이미지
            PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 0.5)
                )
            
            // 제목
            VStack(alignment: .leading, spacing: 4) {
                Text("영화 \(movie.id)")
                    .font(.system(size: 14))
                    .foregroundColor(CHColors.textColor)
                    .lineLimit(1)
                
                // 평점
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 12))
                    
                    Text(String(format: "%.1f", 8.0 + Double(movie.id % 20) / 10))
                        .font(.system(size: 12))
                        .foregroundColor(CHColors.secondaryColor)
                }
                
                // OTT 플랫폼 뱃지 (선택된 OTT)
                HStack(spacing: 2) {
                    Image(systemName: selectedOTT.iconName)
                        .foregroundColor(selectedOTT.color)
                        .font(.system(size: 10))
                    
                    Text("독점")
                        .font(.system(size: 9))
                        .foregroundColor(CHColors.textColor)
                }
                .padding(.horizontal, 4)
                .padding(.vertical, 2)
                .background(selectedOTT.color.opacity(0.2))
                .cornerRadius(3)
            }
            .frame(width: 120)
        }
    }
}
