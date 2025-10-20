//
//  NaverLoginBtnView.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import SwiftUI

struct NaverLoginBtnView: View {
    @State private var viewModel = NaverLoginViewModel()
    
    var body: some View {
        Button(action: {
            viewModel.login()
        }, label: {
            HStack {
                Image("NaverLogo")
                    .resizable()
                    .frame(width: 15, height: 15)
                Text("네이버로 계속하기")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.white)
            }
            .hidden()
            .frame(width: 330, height: 44)
            .background(Color("NaverColor"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        })
        
        .fullScreenCover(isPresented: $viewModel.shouldNavigateToMain) {
            MainTabView()
        }

    }
}
