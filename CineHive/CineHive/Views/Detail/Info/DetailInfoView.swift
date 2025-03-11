//
//  DetailInfoView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailInfoView: View {
    let movie: MovieDetail
    private let textColor = Color.white
    private let secondaryTextColor = Color.gray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            //MARK: 영화 정보
            VStack(alignment: .leading, spacing: 16) {
                Text("영화 정보")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 12) {
                    detailRow(label: "개봉일", value: movie.releaseDate)
                    detailRow(label: "장르", value: ["액션", "드라마", "SF"].joined(separator: ", "))
                    detailRow(label: "국가", value: "미국, 영국") // 임시 데이터
                    detailRow(label: "상영 시간", value: "\(Int.random(in: 90...180))분") // 임시 데이터
                    detailRow(label: "등급", value: ["G", "PG-13", "R", "15세 이상"].randomElement() ?? "")
                    detailRow(label: "제작사", value: ["워너 브라더스", "디즈니", "소니 픽처스"].randomElement() ?? "")
                }
            }
            
            //MARK: 기술적 정보
            VStack(alignment: .leading, spacing: 16) {
                Text("기술 정보")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 12) {
                    detailRow(label: "음향", value: ["Dolby Atmos", "DTS:X"].randomElement() ?? "")
                    detailRow(label: "화질", value: ["4K UHD", "HDR10+"].randomElement() ?? "")
                    detailRow(label: "자막", value: "한국어, 영어, 일본어, 중국어")
                }
            }
        }
        .padding(.bottom, 20)
    }
    
    //MARK: 상세 정보 행
    private func detailRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(secondaryTextColor)
                .frame(width: 80, alignment: .leading)
            
            Text(value)
                .font(.system(size: 15))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    DetailInfoView(movie: MovieDetail.dummy)
        .background(.black)
}
