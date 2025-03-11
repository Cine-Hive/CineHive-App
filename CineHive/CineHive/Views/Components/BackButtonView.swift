//
//  BackButton.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct BackButtonView: View {
    let action: () -> Void
    let color: Color

    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(color)
                .padding(12)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
        }
        .padding(.leading, 16)
    }
}
