//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct DetailView: View {
    let movie: Movie
    
    var body: some View {
            VStack {
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .padding()

                if let posterURL = movie.posterURL {
                    AsyncImage(url: posterURL) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 200, height: 300)
                    }
                    .frame(width: 200, height: 300)
                    .cornerRadius(8)
                }

                Text(movie.overview)
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .padding()
            .navigationTitle("영화 상세 정보")
        }
}

#Preview {
    DetailView(movie: Movie.dummyMovie)
}
