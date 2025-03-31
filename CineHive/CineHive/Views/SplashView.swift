//
//  SplashView.swift
//  CineHive
//
//  Created by 이종민 on 4/1/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            CHColors.primaryColor.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(Color("LoginBtnColor"))
                    .padding(.bottom, 20)
                
                Text("CineHive")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(Color("LoginBtnColor"))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
        .edgesIgnoringSafeArea(.all)
    }
}
