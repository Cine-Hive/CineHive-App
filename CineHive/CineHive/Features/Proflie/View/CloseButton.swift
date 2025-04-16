//
//  CloseButton.swift
//  CineHive
//
//  Created by 이종민 on 4/17/25.
//

import SwiftUI

struct CloseButton: View {
    var action: () -> Void
    var iconColor: Color = .gray
    var iconScale: Image.Scale = .large
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(iconColor)
                .imageScale(iconScale)
        }
    }
}

#Preview {
    VStack {
        CloseButton(action: {
            print("Close button tapped")
        })
        
        CloseButton(
            action: {
                print("Custom close button tapped")
            },
            iconColor: .red,
            iconScale: .medium
        )
    }
    .padding()
}
