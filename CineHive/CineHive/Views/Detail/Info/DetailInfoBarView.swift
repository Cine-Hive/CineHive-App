//
//  DetailInfoBarView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailInfoBarView: View {
    let movie: MovieDetail
    let secondaryTextColor: Color
    let backgroundColor: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", movie.voteAverage))
                    .fontWeight(.semibold)
            }
            Text("•").foregroundColor(secondaryTextColor)
            Text(String(movie.releaseDate.prefix(4)))
            Text("•").foregroundColor(secondaryTextColor)
            Text("\(Int(movie.popularity)) 관심")
            Text("•").foregroundColor(secondaryTextColor)
            Text("\(Int.random(in: 90...180))분")
            Spacer()
        }
        .font(.system(size: 14))
        .foregroundColor(secondaryTextColor)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
    }
}

#Preview {
    DetailInfoBarView(
        movie: MovieDetail.dummy,
        secondaryTextColor: .gray,
        backgroundColor: .black
    )
    .background(.black)
}
