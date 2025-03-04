//
//  DetailRelatedView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailRelatedView: View {
    private let textColor = Color.white
    private let secondaryTextColor = Color.gray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("비슷한 콘텐츠")
                .font(.system(size: 18, weight: .bold))
                .padding(.horizontal, 16)
            
            relatedMoviesRow(title: "장르가 비슷한 영화")
            relatedMoviesRow(title: "같은 감독의 영화")
            relatedMoviesRow(title: "팬들이 좋아하는 영화")
        }
    }
    
    // 관련 영화 행
    private func relatedMoviesRow(title: String) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 16)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(1...6, id: \.self) { _ in
                        VStack(alignment: .leading, spacing: 6) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 120, height: 180)
                                .cornerRadius(4)
                            
                            Text(["어벤져스", "인셉션", "인터스텔라", "기생충", "다크 나이트"].randomElement() ?? "영화 제목")
                                .font(.system(size: 14))
                                .foregroundColor(textColor)
                                .lineLimit(1)
                                .frame(width: 120, alignment: .leading)
                            
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                                Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                                    .font(.system(size: 12))
                                    .foregroundColor(secondaryTextColor)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    DetailRelatedView()
}
