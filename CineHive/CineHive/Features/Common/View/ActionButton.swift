//
//  ActionButton.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct ActionButton: View {
    let imageName: String
    let text: String
    let textColor: Color
    var isActive: Bool = false
    var action: (() -> Void)? = nil
    
    var body: some View {
        Group {
            if let action = action {
                Button(action: action) {
                    content
                }
            } else {
                content //액션이 없는 경우, 단순한 버튼 모양 유지
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var content: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .font(.system(size: 18))
                .symbolEffect(.bounce, value: isActive)
            Text(text)
                .font(.system(size: 12))
        }
        .foregroundColor(textColor)
    }
}
