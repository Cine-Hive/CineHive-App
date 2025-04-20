//
//  BioSectionView.swift
//  CineHive
//
//  Created by 이종민 on 4/17/25.
//

import SwiftUI

/// 사용자 소개글 섹션을 표시하는 컴포넌트
struct BioSectionView: View {
    let bio: String?
    
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    private let primaryColor = CHColors.primaryColor
    
    var body: some View {
        if let bio, !bio.isEmpty {
            VStack(alignment: .leading, spacing: 8) {
                Label {
                    Text("소개")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(secondaryColor)
                } icon: {
                    Image(systemName: "quote.opening")
                        .foregroundStyle(primaryColor)
                        .font(.caption)
                }
                
                Text(bio)
                    .font(.body)
                    .foregroundStyle(textColor)
                    .lineLimit(3)
                    .padding(.leading, 4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 12)
        }
    }
}

#Preview {
    BioSectionView(
        bio: "영화를 사랑하는 사람입니다. 주로 스릴러, SF를 좋아합니다."
    )
    .background(CHColors.backgroundColor)
    .preferredColorScheme(.dark)
} 