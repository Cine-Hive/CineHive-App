//
//  TermsSection.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import Foundation

enum TermsSection: String, CaseIterable, Hashable {
    case purpose = "제 1조 (목적)"
    case definition = "제 2조 (정의)"
    case registration = "제 3조 (회원가입)"
    case use = "제 4조 (서비스 이용)"
    case rights = "제 5조 (권리와 의무)"
    case termination = "제 6조 (계약 해지)"
    case privacy = "제 7조 (개인정보 보호)"
    case liability = "제 8조 (책임 제한)"
    case dispute = "제 9조 (분쟁 해결)"
    case others = "제 10조 (기타 사항)"
}
