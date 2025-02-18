//
//  KakaoLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI

struct KakaoLoginBtnView: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Image("KakaoLogo")
                    .resizable()
                    .frame(width: 18, height: 18)
                Text("Kakao로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black)
            }
            .frame(width: 330, height: 44)
            .background(Color("KakaoColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        })
    }
}
