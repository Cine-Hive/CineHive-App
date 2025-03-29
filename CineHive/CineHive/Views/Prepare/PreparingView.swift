//
//  PreparingView.swift
//  CineHive
//
//  Created by 이종민 on 3/23/25.
//

import SwiftUI

struct PreparingView: View {
    let type: String
    let actionTitle: String
    let action: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: iconName)
                .font(.system(size: 60))
                .foregroundColor(CHColors.primaryColor)
                .padding()
          
            Text("\(type) 콘텐츠 준비 중...")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(CHColors.textColor)
          
            Text("곧 다양한 \(type) 콘텐츠를 제공해 드릴 예정입니다.\n조금만 기다려주세요!")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .foregroundColor(CHColors.secondaryColor)

            Button {
                dismiss()
                action()
            } label: {
                Text(actionTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(CHColors.primaryColor)
                    .cornerRadius(8)
                    .padding(.top, 20)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(CHColors.backgroundColor)
        .navigationBarBackButtonHidden(true)
    }

    private var iconName: String {
        switch type {
        case "드라마": return "tv"
        case "애니메이션": return "movieclapper"
        case "다큐멘터리": return "book.fill"
        case "커뮤니티", "게시글 상세": return "sparkles"
        default: return "sparkles"
        }
    }
}
