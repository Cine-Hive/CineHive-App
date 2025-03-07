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
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: imageName)
                    .font(.system(size: 18))
                    .symbolEffect(.bounce, value: isActive)
                Text(text)
                    .font(.system(size: 12))
            }
            .foregroundColor(textColor)
            .frame(maxWidth: .infinity)
        }
    }
}
