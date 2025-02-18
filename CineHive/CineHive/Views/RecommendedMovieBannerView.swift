//
//  RecommendedMovieBannerView.swift
//  CineHive
//
//  Created by 이종민 on 2/19/25.
//

import SwiftUI

struct RecommendedMovieBanner: View {
    let imageURL: URL?
    let title: String
    let subtitle: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // 배너 이미지
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(ProgressView())
            }
            .frame(height: 220)
            .clipped()
            
            // 그라디언트 오버레이
            LinearGradient(
                gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 100)
            .allowsHitTesting(false)
            
            // 텍스트
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                
                Text(subtitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.top, 2)
            }
            .padding(.leading, 16)
            .padding(.bottom, 12)
        }
    }
}
