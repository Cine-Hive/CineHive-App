//
//  AuthSignUpRequest.swift
//  CineHive
//
//  Created by 존진 on 9/17/25.
//

import Foundation

// 소셜 회원 가입 요청 DTO
struct AuthSignUpRequest: Encodable {
    let email: String
    let password: String
}
