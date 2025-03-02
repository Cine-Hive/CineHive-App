//
//  BannerView.swift
//  CineHive
//
//  Created by 이종민 on 2/18/25.
//

import SwiftUI

struct BannerView: View {
    let items: [BannerItem]
    
    var body: some View {
        TabView {
            ForEach(items) { item in
                BannerItemView(item: item)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .frame(height: 450)
    }
}

// ✅ 배너 아이템 뷰
struct BannerItemView: View {
    let item: BannerItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: item.imageURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(ProgressView().tint(.white))
            }
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, Color.black.opacity(0.8)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 250)
            .allowsHitTesting(false)
            
            VStack(alignment: .leading, spacing: 16) {
                Text(item.title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text(item.subtitle)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                
                TagRow(tags: ["액션", "SF", "스릴러"])
                
                HStack(spacing: 16) {
                    PrimaryButton(title: "재생", icon: "play.fill", backgroundColor: .white, textColor: .black)
                    PrimaryButton(title: "내 리스트", icon: "plus", backgroundColor: .gray.opacity(0.3), textColor: .white)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 32)
        }
    }
}

// ✅ 태그 뷰
struct TagRow: View {
    let tags: [String]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(3)
            }
        }
    }
}

// ✅ 버튼 컴포넌트
struct PrimaryButton: View {
    let title: String
    let icon: String
    let backgroundColor: Color
    let textColor: Color
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(4)
        }
    }
}
