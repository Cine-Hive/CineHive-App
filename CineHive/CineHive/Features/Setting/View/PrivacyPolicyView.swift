//
//  PrivacyPolicyView.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    private let backgroundColor = CHColors.backgroundColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("개인정보 처리방침")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(textColor)
                
                Text("최종 업데이트: 2025년 4월 1일")
                    .font(.subheadline)
                    .foregroundStyle(secondaryColor)
                
                VStack(alignment: .leading, spacing: 16) {
                    privacySection(
                        title: "1. 수집하는 개인정보",
                        content: "CineHive는 서비스 제공을 위해 다음과 같은 개인정보를 수집합니다: 이름, 이메일 주소, 프로필 정보, 기기 정보, 사용 데이터."
                    )
                    
                    privacySection(
                        title: "2. 개인정보 이용 목적",
                        content: "수집된 개인정보는 다음과 같은 목적으로 사용됩니다: 서비스 제공 및 개선, 계정 관리, 고객 지원, 마케팅(동의한 경우에 한함)."
                    )
                    
                    privacySection(
                        title: "3. 개인정보 보유 기간",
                        content: "개인정보는 서비스 이용 기간 동안 보관되며, 계정 삭제 시 관련 법령에 따라 일정 기간 보관 후 안전하게 파기됩니다."
                    )
                    
                    privacySection(
                        title: "4. 개인정보 보호 조치",
                        content: "CineHive는 사용자의 개인정보를 보호하기 위해 암호화, 접근 제한, 보안 시스템 등 적절한 기술적, 관리적 조치를 취하고 있습니다."
                    )
                    
                    privacySection(
                        title: "5. 사용자 권리",
                        content: "사용자는 개인정보에 대한 접근, 수정, 삭제, 처리 제한 등의 권리를 가집니다. 문의사항은 privacy@cinehive.com으로 연락해 주세요."
                    )
                }
            }
            .padding()
        }
        .background(backgroundColor.ignoresSafeArea())
        .navigationTitle("개인정보 처리방침")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("닫기") {
                    dismiss()
                }
            }
        }
    }
    
    private func privacySection(title: String, content: String) -> some View {
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
    PrivacyPolicyView()
        .preferredColorScheme(.dark)
}
