//
//  CustomRefreshTestView.swift
//  CineHive
//
//  Created by 이종민 on 3/23/25.
//

import SwiftUI

struct CustomRefreshTestView: View {
    @State private var isRefreshing = false

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            // 테스트 대상 뷰
            CustomRefreshView(isRefreshing: isRefreshing)

            Spacer()

            // 토글 버튼
            Button(isRefreshing ? "로딩 중지" : "로딩 시작") {
                isRefreshing.toggle()

                // 자동으로 3초 뒤에 로딩 종료
                if isRefreshing {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isRefreshing = false
                        }
                    }
                }
            }
            .padding()
            .background(isRefreshing ? Color.red : Color.green)
            .foregroundColor(.white)
            .cornerRadius(15)
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    CustomRefreshTestView()
}
