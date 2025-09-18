//
//  SignUpViewModel.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import Foundation
import Supabase
import Auth
import PostgREST

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
    
    // 닉네임 중복 검사 (RPC 사용)
    @MainActor
    func checkValidateNickname() async {
        // 공백이나 줄바꿈 문자 제거
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let client = SupabaseConfig.shared.client
            // 파라미터 타입을 명시적으로 AnyJSON으로 지정
            let params: [String: AnyJSON] = [
                "p_nickname": .string(trimmed)
            ]
            let response = try await client
                .rpc("check_nickname_available", params: params)
                .execute()
            
            let data = response.data
            guard !data.isEmpty else {
                self.nicknameAvailable = false
                self.nicknameCheckMessage = "닉네임 확인 실패: 빈 응답"
                return
            }
            
            // 단일 Bool (true/false)
            if let available = try? JSONDecoder().decode(Bool.self, from: data) {
                self.nicknameAvailable = available
                self.nicknameCheckMessage = available ? "사용 가능한 닉네임입니다." : "이미 사용 중인 닉네임입니다."
                return
            }
            
            // 파싱 실패
            self.nicknameAvailable = false
            self.nicknameCheckMessage = "닉네임 확인 실패: 응답 형식 오류"
        } catch {
            self.nicknameAvailable = false
            self.nicknameCheckMessage = "닉네임 확인 실패: \(error.localizedDescription)"
        }
    }
    
    // 회원가입
    @MainActor
    func signUp() async {
        isSigningUp = true
        defer { isSigningUp = false }
        generalErrorMessage = nil
        let convertedGender = (gender == "남자") ? "MALE" : "FEMALE"
        
        do {
            let client = SupabaseConfig.shared.client
            
            let metadata: [String: AnyJSON] = [
                "nickname": .string(nickname),
                "name": .string(name),
                "gender": .string(convertedGender)
            ]
            
            // Supabase Auth 회원가입
            let authResponse = try await client.auth.signUp(
                email: email,
                password: password,
                data: metadata
            )
            
            // 세션 O -> Supabase trigger에서 프로필 생성 처리
            if let session = authResponse.session {
                // 프로필 생성은 Supabase 트리거에서 처리
            }
            // 세션 X -> 이메일 인증 필요
            else if authResponse.user != nil {
                isSignUpSuccess = true
                // 프로필 생성은 이메일 인증 후 로그인 시점에 진행
            } else {
                throw NSError(domain: "SignUp", code: -2, userInfo: [NSLocalizedDescriptionKey: "회원가입 응답에 세션/사용자 정보가 없습니다."])
            }
        } catch {
            let msg = error.localizedDescription.lowercased()
            if msg.contains("already registered") || msg.contains("already exists") || msg.contains("user exists") {
                generalErrorMessage = "이미 사용 중인 이메일입니다."
            } else if msg.contains("password") {
                generalErrorMessage = "비밀번호 요건을 확인해 주세요."
            } else {
                generalErrorMessage = "회원가입 실패: \(error.localizedDescription)"
            }
            isSignUpSuccess = false
            
        }
    }
}
