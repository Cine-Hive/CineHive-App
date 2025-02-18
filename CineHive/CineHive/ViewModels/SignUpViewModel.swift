//
//  SignUpViewModel.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import Foundation

@Observable
class SignUpViewModel {
    var email: String = "" {
        didSet {
            validateEmail() // 이메일 입력이 변경될 때마다 검사
        }
    }
    var password: String = ""
    var nickname: String = ""
    var name: String = ""
    var selectedGender: String = ""
    var showPassword: Bool = false
    var emailErrorMessage: String? = nil // 이메일 오류 메시지
    
    // 필수 필드 채워져 있는지 검사
    func isValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && !nickname.isEmpty && isValidEmail(email)
    }
    
    // 이메일 정규식 검사 함수
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // 이메일 검사 후 오류 메시지 업데이트
    func validateEmail() {
        if email.isEmpty {
            emailErrorMessage = nil
        } else if !isValidEmail(email) {
            emailErrorMessage = "이메일의 형식이 맞지 않습니다."
        } else {
            emailErrorMessage = nil
        }
    }
    
}
