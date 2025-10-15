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

extension SignUpViewModel {
    func isNextEnabled(step: SignUpStep) -> Bool {
        switch step {
        case .email:
            return !email.isEmpty && isValidEmail(email)
        case .password:
            // 비밀번호 입력란이 비어 있지 않고, 체크리스트 조건 중 최소 한 가지 이상은 충족해야 다음 단계로 이동 가능
            return !password.isEmpty && passwordChecks.allSatisfy { $0.passed }
        case .confirmPassword:
            return !confirmPassword.isEmpty && password == confirmPassword
        case .nickname:
            return !nickname.isEmpty
        }
    }
    var passwordChecks: [(title: String, passed: Bool)] {
        [
            ("8자 이상 입력해 주세요.", password.count >= 8),
            ("대소문자를 포함해 주세요.", password.range(of: "[A-Z]", options: .regularExpression) != nil &&
             password.range(of: "[a-z]", options: .regularExpression) != nil),
            ("숫자 및 특수문자를 포함해 주세요.", password.range(of: "[0-9][!@#$%^&*(),.?\\\":{}|<>]", options: .regularExpression) != nil),
        ]
    }
}

@Observable
class SignUpViewModel {
    // 사용자 입력 데이터
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    var nickname: String = ""
    var showPassword: Bool = false
    
    // 상태 및 오류 메시지
    var emailFormatInvalidMessage: String? = nil
    var nicknameAvailable: Bool = false
    var nicknameCheckMessage: String = ""
    var emailAvailable: Bool = false
    var emailCheckMessage: String = ""
    var isSignUpSuccess: Bool = false
    var isSigningUp: Bool = false
    var generalErrorMessage: String? = nil
    
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
    
    // 이메일 중복 검사 (RPC 사용)
    @MainActor
    func checkValidateEmail() async {
        let trimmed = email.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let available = try await UserService.shared.fetchUserEmail(email: trimmed)
            
            if available {
                self.emailCheckMessage = "사용 가능한 이메일이에요."
                self.emailAvailable = true
            } else {
                self.emailCheckMessage = "이미 사용 중인 이메일이에요."
                self.emailAvailable = false
            }

        } catch {
            self.emailCheckMessage = "이메일 확인 실패: \(error.localizedDescription)"
        }
    }
    
    // 닉네임 중복 검사 (RPC 사용)
    @MainActor
    func checkValidateNickname() async {
        // 공백이나 줄바꿈 문자 제거
        let trimmed = nickname.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let available = try await UserService.shared.fetchUserNickname(nickname: trimmed)
            
            if available {
                self.nicknameCheckMessage = "사용 가능한 이메일이에요."
                self.nicknameAvailable = true
            } else {
                self.nicknameCheckMessage = "이미 사용 중인 이메일이에요."
                self.nicknameAvailable = false
            }

        } catch {
            self.nicknameCheckMessage = "닉네임 확인 실패: \(error.localizedDescription)"
        }
    }
    
    // 회원가입
    @MainActor
    func signUp() async {
        isSigningUp = true
        defer { isSigningUp = false }
        generalErrorMessage = nil
        
        do {
            let client = SupabaseConfig.shared.client
            
            let metadata: [String: AnyJSON] = [
                "nickname": .string(nickname)
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
