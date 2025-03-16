//
//  FeaturedBannerItemView.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct FeaturedBannerItemView: View {
    let item: BannerItem
    @State private var isHovered = false
    
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Banner image with proper aspect ratio
            AsyncImage(url: item.imageURL) { phase in
                switch phase {
                case .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(16/9, contentMode: .fill)
                        .overlay(ProgressView().tint(.white))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .aspectRatio(16/9, contentMode: .fill)
                        .overlay(
                            Image(systemName: "photo")
                                .font(.largeTitle)
                                .foregroundColor(.white.opacity(0.7))
                        )
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 250)
            .clipped()
            
            // Gradient overlay
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.clear,
                    backgroundColor.opacity(0.5),
                    backgroundColor.opacity(0.8),
                    backgroundColor
                ]),
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 250)
            .allowsHitTesting(false)
            
            // Text and buttons
            VStack(alignment: .leading, spacing: 16) {
                // Title information
                VStack(alignment: .leading, spacing: 5) {
                    Text(item.title)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(item.subtitle)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 2)
                }
                
                // Genre tags
                TagRow(tags: ["액션", "SF", "스릴러"])
                
                // OTT availability
                HStack(spacing: 8) {
                    Text("시청 가능한 OTT:")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "n.square.fill")
                        .foregroundColor(.red)
                    
                    Image(systemName: "d.square.fill")
                        .foregroundColor(.blue)
                    
                    Image(systemName: "w.square.fill")
                        .foregroundColor(.cyan)
                }
                
                // Action buttons
                HStack(spacing: 16) {
                    // Info button
                    Button {
                        // Navigate to detail view
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "info.circle")
                            Text("상세 정보")
                                .fontWeight(.semibold)
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(accentColor)
                        .foregroundColor(textColor)
                        .cornerRadius(4)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(ScaleButtonStyle())
                    
                    // My list button
                    Button {
                        // Add to my list
                        let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                        impactFeedback.impactOccurred()
                        isHovered.toggle() // Toggle to trigger the symbol effect
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "plus")
                                .symbolEffect(.bounce, options: .speed(2), value: isHovered)
                            Text("내 리스트")
                                .fontWeight(.medium)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.3))
                        .foregroundColor(textColor)
                        .cornerRadius(4)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
    }
}
