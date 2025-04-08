//
//  CustomShareSheetView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct CustomShareSheetView: View {
    let movie: MovieDetail
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 헤더
            headerView
            
            // 영화 정보 미리보기
            MoviePreviewCard(movie: movie)
            
            // 공유 옵션 리스트
            SharingOptionsListView(movie: movie)
            
            Spacer()
        }
        .padding(20)
        .background(Color.black)
    }
    
    private var headerView: some View {
        HStack {
            Text("영화 공유하기")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
        }
    }
}



#Preview {
    let dummyMovie = MovieDetail.dummy
    CustomShareSheetView(movie: dummyMovie)
}
