//
//  PosterView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct PosterView: View {
    let posterURL: URL?
    
    var body: some View {
        AsyncImage(url: posterURL) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 180)
                    .cornerRadius(10)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 180)
                    .clipped()
                    .cornerRadius(10)
                    .shadow(radius: 4)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 180)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}
