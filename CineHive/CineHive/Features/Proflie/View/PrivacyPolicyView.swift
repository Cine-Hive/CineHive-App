//
//  PrivacyPolicyView.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                CHColors.backgroundColor.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("개인정보 처리방침")
                            .font(.title2.bold())
                            .foregroundColor(CHColors.textColor)

                        ForEach(PrivacyContent.contents, id: \.self) { paragraph in
                            Text(paragraph)
                                .font(.body)
                                .foregroundColor(CHColors.textColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("개인정보 처리방침")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) {
                        Text("닫기")
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#Preview {
    PrivacyPolicyView()
        .preferredColorScheme(.dark)
}
