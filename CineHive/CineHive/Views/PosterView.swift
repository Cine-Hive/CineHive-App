//
//  PosterView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct PosterView: View {
    let posterURL: URL?
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: posterURL) { phase in
            switch phase {
            case .empty:
                placeholderView
            case .success(let image):
                imageView(image)
            case .failure:
                placeholderView
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: width, height: height)
    }
    
    private var placeholderView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .cornerRadius(10)
            .overlay(
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: width * 0.5, height: height * 0.5)
                    .foregroundColor(.gray.opacity(0.6))
            )
    }
    
    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipped()
            .cornerRadius(10)
            .shadow(radius: 4)
    }
}
