//
//  TagRow.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct TagRow: View {
    let tags: [String]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                Text(tag)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(3)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    TagRow(tags: ["액션", "SF", "스릴러"])
        .background(Color.black)
}
