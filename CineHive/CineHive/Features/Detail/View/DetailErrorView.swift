//
//  DetailErrorView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailErrorView: View {
    let errorMessage: String
    let backgroundColor: Color
    let textColor: Color
    let accentColor: Color
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 48))
                .foregroundColor(Color.gray)
                .padding()
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Button(action: {
                retryAction()
            }) {
                Text("다시 시도")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(textColor)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(accentColor)
                    .cornerRadius(4)
                    .padding(.top, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
}

// MARK: - 프리뷰
#Preview {
    DetailErrorView(
        errorMessage: "오류가 발생했습니다.",
        backgroundColor: .black,
        textColor: .white,
        accentColor: .red,
        retryAction: {}
    )
}
