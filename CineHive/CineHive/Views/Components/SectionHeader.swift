//
//  SectionHeader.swift
//  CineHive
//
//  Created by 이종민 on 3/18/25.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    let actionTitle: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                action?()
            } label: {
                Text(actionTitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    SectionHeader(title: "인기 영화", actionTitle: "더보기")
        .background(Color.black)
}
