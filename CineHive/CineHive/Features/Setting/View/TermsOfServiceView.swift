//
//  TermsOfServiceView.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    private let backgroundColor = CHColors.backgroundColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("이용약관")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(textColor)
                
                Text("최종 업데이트: 2025년 4월 1일")
                    .font(.subheadline)
                    .foregroundStyle(secondaryColor)
                
                VStack(alignment: .leading, spacing: 16) {
                    termsSection(
                        title: "1. 서비스 이용 약관",
                        content: "CineHive(이하 '서비스')를 이용해 주셔서 감사합니다. 본 약관은 사용자가 CineHive 서비스를 이용하는 데 적용되는 조건과 규칙을 설명합니다."
                    )
                    
                    termsSection(
                        title: "2. 계정 등록 및 보안",
                        content: "서비스 이용을 위해서는 계정을 등록해야 합니다. 사용자는 계정 정보의 정확성을 유지하고 계정 보안을 위해 비밀번호를 안전하게 관리할 책임이 있습니다."
                    )
                    
                    termsSection(
                        title: "3. 개인정보 보호",
                        content: "당사는 개인정보 보호를 중요하게 생각합니다. 개인정보 수집 및 이용에 관한 자세한 내용은 개인정보 처리방침을 참조하세요."
                    )
                    
                    termsSection(
                        title: "4. 서비스 제공 및 변경",
                        content: "CineHive는 영화 커뮤니티 서비스를 제공합니다. 당사는 서비스 내용을 수정하거나 중단할 권리를 보유합니다. 중요한 변경사항은 사전 공지를 통해 안내됩니다."
                    )
                    
                    termsSection(
                        title: "5. 사용자 콘텐츠",
                        content: "사용자가 서비스에 게시하는 모든 콘텐츠(리뷰, 댓글 등)에 대한 책임은 사용자에게 있습니다. 타인의 권리를 침해하거나 불법적인 콘텐츠를 게시해서는 안 됩니다."
                    )
                }
            }
            .padding()
        }
        .background(backgroundColor.ignoresSafeArea())
        .navigationTitle("이용약관")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("닫기") {
                    dismiss()
                }
            }
        }
    }
    
    private func termsSection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .foregroundStyle(textColor)
            
            Text(content)
                .font(.body)
                .foregroundStyle(textColor.opacity(0.9))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    TermsOfServiceView()
        .preferredColorScheme(.dark)
}
