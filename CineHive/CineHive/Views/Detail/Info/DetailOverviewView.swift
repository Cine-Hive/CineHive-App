//
//  DetailOverviewView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailOverviewView: View {
    let movie: MovieDetail
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(movie.overview)
                .font(.system(size: 15))
                .lineSpacing(6)
                .foregroundColor(.white.opacity(0.9))
                .lineLimit(isExpanded ? nil : 3)
                .padding(.horizontal, 16)
                .animation(.easeInOut(duration: 0.2), value: isExpanded)
            
            if !isExpanded {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text("더보기")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.horizontal, 16)
                }
            }
            
            Text("감독: \(movie.director?.name ?? "정보 없음")")
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
                .padding(.top, 8)
        }
    }
}

#Preview {
    DetailOverviewView(movie: MovieDetail.dummy, isExpanded: .constant(false))
        .background(.black)
}
