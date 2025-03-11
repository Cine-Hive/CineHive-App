//
//  BackdropImageView.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct BackdropImageView: View {
    let url: URL?
    let placeholderColor: Color = Color.gray.opacity(0.3)
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Rectangle().fill(placeholderColor)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                Rectangle().fill(placeholderColor)
            @unknown default:
                Rectangle().fill(placeholderColor)
            }
        }
    }
}
