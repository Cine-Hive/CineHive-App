//
//  SignUpViewModel.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import Foundation

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
        return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && !nickname.isEmpty &&
               isValidEmail(email) && nicknameAvailable && emailAvailable
    }
    
    // 이메일 정규식 검사 함수
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let isValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        return isValid
    }
    
    // 이메일 중복 검사
    @MainActor
    func checkValidateEmail() async {
        let (_, isAvailable) = await UserState.shared.checkEmail(email)
        
        if isAvailable {
            self.emailCheckMessage = "사용 가능한 이메일입니다."
            self.emailAvailable = true
        } else {
            self.emailCheckMessage = "이미 사용 중인 이메일입니다."
            self.emailAvailable = false
        }
    }

    // 이메일 형식 검사 후 중복 검사
    @MainActor
    func checkEmailWithFormatValidation() async {
        if isValidEmail(email) {
            emailFormatInvalidMessage = nil
            await checkValidateEmail()
        } else {
            emailCheckMessage = nil
            emailFormatInvalidMessage = "이메일의 형식이 맞지 않습니다."
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
