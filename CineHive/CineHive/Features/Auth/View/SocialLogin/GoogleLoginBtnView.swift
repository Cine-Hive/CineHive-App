//
//  GoogleLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI

struct GoogleLoginBtnView: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            HStack {
                Image("GoogleLogo")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .offset(x: 3)
                Text("Google로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.black)
            }
            .frame(width: 330, height: 44)
            .background(Color("GoogleColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        })
    }
}
