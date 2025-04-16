//
//  BackButton.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct BackButtonView: View {
    var action: () -> Void
    var color: Color = .white
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.left")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(color)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
    }
}


#Preview("BackButtonView - Preview") {
    ZStack {
        Color.gray.opacity(0.3).ignoresSafeArea()
        BackButtonView(action: {
            print("BackButtonView tapped")
        }, color: .black)
    }
}
