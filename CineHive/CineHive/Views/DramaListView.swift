//
//  DramaListView.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct DramaListView: View {
    let dramas: [Drama]
    let dramaType: DramaListType
    @State var viewModel: DramaViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 15) {
                ForEach(dramas, id: \.id) { movie in
                    NavigationLink(destination: DetailView(movieId: movie.id)) {
                        VStack(alignment: .leading, spacing: 6) {
                            // 포스터 이미지
                            PosterView(posterURL: movie.posterURL, width: 120, height: 180)
                            // 제목
                            Text("드라마 제목")
                                .font(.system(size: 14))
                                .foregroundColor(CHColors.textColor)
                                .lineLimit(1)
                                .frame(width: 120, alignment: .leading)
                            
                            // 평점
                            HStack {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                    .font(.system(size: 12))
                                Text(String(format: "%.1f", Double.random(in: 6.0...9.8)))
                                    .font(.system(size: 12))
                                    .foregroundColor(CHColors.secondaryColor)
                            }
                        }
                    }
                }
            }
            .padding(.leading, 5)
            .padding(.trailing, 15)
        }
    }
}
