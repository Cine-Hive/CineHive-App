//
//  NaverLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI

struct NaverLoginBtnView: View {
    var body: some View {
        Button(action: {}, label: {
            HStack {
                Image("NaverLogo")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("Naver로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
            }
            .frame(width: 330, height: 44)
            .background(Color("NaverColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        })
    }
}
