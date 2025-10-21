//
//  AuthSignUpRequest.swift
//  CineHive
//
//  Created by 존진 on 9/17/25.
//

import Foundation
import Supabase

// 소셜 회원 가입 요청 DTO
struct AuthSignUpRequest: Encodable {
    let email: String
    let password: String
    let data: [String: AnyJSON]
    
    init(email: String, password: String, nickname: String) {
        self.email = email
        self.password = password
        self.data = [
            "nickname": .string(nickname)
        ]
    }
}
