//
//  SignUpViewModel.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import Foundation

enum PasswordValidationError: String {
    case space = "공백 문자는 사용할 수 없습니다."
    case length = "비밀번호는 8~20자여야 합니다."
    case upper = "대문자를 최소 1개 포함해야 합니다."
    case lower = "소문자를 최소 1개 포함해야 합니다."
    case digit = "숫자를 최소 1개 포함해야 합니다."
    case special = "특수문자를 최소 1개 포함해야 합니다."
}


@Observable
class SignUpViewModel {
    // 사용자 입력 데이터
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var name: String = ""
    var nickname: String = ""
    var gender: String = ""
    var genres: [String] = []
    var showPassword: Bool = false
    
    // 상태 및 오류 메시지
    var emailFormatInvalidMessage: String? = nil
    var nicknameAvailable: Bool = false
    var nicknameCheckMessage: String? = nil
    var emailAvailable: Bool = false
    var emailCheckMessage: String? = nil
    var isSignUpSuccess: Bool = false
    var isSigningUp: Bool = false
    var generalErrorMessage: String? = nil
    
    // 필수 필드 채워져 있는지 검사 및 중복검사 결과에 따른 회원가입 버튼 활성화
    func isValid() -> Bool {
        let validEmail = isValidEmail(email)
        let (validPassword, _) = isValidPassword(password)
        let confirmPasswordMatch = !confirmPassword.isEmpty && password == confirmPassword
        return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !nickname.isEmpty &&
        validEmail && validPassword && confirmPasswordMatch && nicknameAvailable
    }
    
    // 비밀번호 유효성 검사: 영문 대소문자, 숫자, 특수문자 포함 8~20자, 공백 불가
    func isValidPassword(_ password: String) -> (Bool, PasswordValidationError?) {
        if password.contains(where: { $0.isWhitespace }) {
            return (false, .space)
        }
        if password.count < 8 || password.count > 20 {
            return (false, .length)
        }
        if password.range(of: "[A-Z]", options: .regularExpression) == nil {
            return (false, .upper)
        }
        if password.range(of: "[a-z]", options: .regularExpression) == nil {
            return (false, .lower)
        }
        if password.range(of: "[0-9]", options: .regularExpression) == nil {
            return (false, .digit)
        }
        if password.range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) == nil {
            return (false, .special)
        }
        return (true, nil)
    }
    
    var passwordErrorMessage: String? {
        return isValidPassword(password).1?.rawValue
    }
    
    // 이메일 정규식 검사 함수
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        return isValid
    }
    
    // 이메일 형식 검사
    @MainActor
    func checkEmailWithFormatValidation() async {
        if !isValidEmail(email) {
            self.emailFormatInvalidMessage = nil
            self.emailCheckMessage = "이메일 형식이 유효하지 않습니다."
            self.emailAvailable = false
        } else {
            self.emailFormatInvalidMessage = nil
            self.emailCheckMessage = ""
            self.emailAvailable = true
        }
    }
    
    // 닉네임 중복 검사
    @MainActor
    func checkValidateNickname() async {
        let (_, isAvailable) = await UserState.shared.checkNickname(nickname)
        
        if isAvailable {
            self.nicknameCheckMessage = "사용 가능한 닉네임입니다."
            self.nicknameAvailable = true
        }else {
            self.emailCheckMessage = "이미 사용 중인 닉네임입니다."
            self.nicknameAvailable = false
        }
    }
    
    // 회원가입
    @MainActor
    func signUp() async {
        isSigningUp = true
        generalErrorMessage = nil
        let convertedGender = (gender == "남자") ? "MALE" : "FEMALE"
        
        let newUser = SignUpRequest(
            email: email,
            password: password,
            confirmPassword: confirmPassword,
            name: name,
            nickname: nickname,
            gender: convertedGender,
            genres: genres
        )
        
        let success = await UserState.shared.signUp(user: newUser)
        
        isSigningUp = false
        
        if success {
            isSignUpSuccess = true
        } else {
            generalErrorMessage = UserState.shared.errorMessage ?? "회원가입에 실패했습니다."
        }
    }
}
