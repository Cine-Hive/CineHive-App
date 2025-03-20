//
//  HomeBannerView.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import SwiftUI

struct HomeBannerView: View {
    let banners: [BannerItem]
    
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // 자동 슬라이드되는 배너
            TabView(selection: $currentIndex) {
                ForEach(banners.indices, id: \.self) { index in
                    BannerItemView(banner: banners[index])
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .animation(.easeInOut(duration: 0.5), value: currentIndex)
            .onReceive(timer) { _ in
                withAnimation {
                    currentIndex = (currentIndex + 1) % banners.count
                }
            }
            .frame(height: 180)
        }
    }
}

// MARK: - 개별 배너 뷰
struct BannerItemView: View {
    let banner: BannerItem
    
    var body: some View {
        ZStack(alignment: .leading) {
            if let imageURL = banner.imageURL {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(16/9, contentMode: .fill)
                            .overlay(ProgressView().tint(.white))
                            .cornerRadius(8)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(16/9, contentMode: .fill)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(8)
                            .clipped()
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(16/9, contentMode: .fill)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.white.opacity(0.7))
                            )
                            .cornerRadius(8)
                    @unknown default:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .aspectRatio(16/9, contentMode: .fill)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.white.opacity(0.7))
                            )
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity)
                .clipped()
            }

            BannerInfo(banner: banner)
        }
    }
}

// MARK: - 배너 정보 (텍스트)
private func BannerInfo(banner: BannerItem) -> some View {
    VStack(alignment: .leading, spacing: 16) {
        VStack(alignment: .leading, spacing: 5) {
            Text("오늘의 추천")
                .font(.title3)
                .foregroundColor(.gray)
            
            Text(banner.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(2)
                .padding(.top, 0)
                .padding(.bottom, 10)
            
            Button {
                // 상세 정보 액션
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "info.circle")
                    Text("상세 정보")
                        .fontWeight(.semibold)
                        .font(.subheadline)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 7)
                .background(Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(4)
            }
        }
    }
    .padding(.horizontal, 16)
}

// MARK: - 미리보기
#Preview {
    HomeBannerView(banners: BannerItem.dummyBanners)
}
