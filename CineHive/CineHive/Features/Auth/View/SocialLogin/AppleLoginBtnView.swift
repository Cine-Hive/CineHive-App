//
//  AppleLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI

struct AppleLoginBtnView: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Image(systemName: "apple.logo")
                    .resizable()
                    .frame(width: 17, height: 20)
                    .foregroundStyle(.white)
                Text("Apple로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 330, height: 44)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        })
    }
}
