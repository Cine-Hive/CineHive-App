//
//  RecommendedMovieBannerView.swift
//  CineHive
//
//  Created by 이종민 on 2/19/25.
//

import SwiftUI

struct RecommendedMovieBanner: View {
    /// 여러 배너 아이템을 한 번에 받아와서 TabView로 순환
    let items: [BannerItem]
    
    var body: some View {
        TabView {
            ForEach(items) { item in
                ZStack(alignment: .bottomLeading) {
                    // 배너 이미지
                    AsyncImage(url: item.imageURL) { image in
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
                    
                    // 아래쪽 그라디언트 오버레이 (텍스트 가독성 향상)
                    LinearGradient(
                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .frame(height: 100)
                    .allowsHitTesting(false)
                    
                    // 텍스트
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.title)
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text(item.subtitle)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 2)
                    }
                    .padding(.leading, 16)
                    .padding(.bottom, 12)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // 페이지 인디케이터
        .frame(height: 220)
    }
}

#Preview {
    RecommendedMovieBanner(items: [
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500/9nhjGaFLKtddDPtPaX5EmKqsWdH.jpg"),
            title: "오늘의 추천 영화",
            subtitle: "인셉션: 꿈 속의 꿈"
        ),
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w500/8s4h9friP6Ci3adRGahHARVd76E.jpg"),
            title: "오늘의 추천 영화",
            subtitle: "인터스텔라: 우주 속의 꿈"
        )
    ])
}

