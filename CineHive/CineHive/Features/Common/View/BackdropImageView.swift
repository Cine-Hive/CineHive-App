//
//  BackdropImageView.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct BackdropImageView: View {
    let url: URL?
    
    var body: some View {
        GeometryReader { geometry in
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholderView(width: geometry.size.width)
                case .success(let image):
                    imageView(image, width: geometry.size.width)
                case .failure:
                    placeholderView(width: geometry.size.width)
                @unknown default:
                    EmptyView()
                }
            }
        }
        .frame(height: UIScreen.main.bounds.width * 9/16) // 16:9 비율 유지
    }
    
    private func placeholderView(width: CGFloat) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .frame(width: width)
            .overlay(
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.2)
                    .foregroundColor(.gray.opacity(0.6))
            )
    }
    
    private func imageView(_ image: Image, width: CGFloat) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width)
            .clipped()
            .cornerRadius(10)
    }
}
