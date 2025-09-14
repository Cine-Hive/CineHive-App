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
    
    // 닉네임 중복 검사
    @MainActor
    func checkValidateNickname() async {
        do {
            let client = SupabaseConfig.shared.client
            let response = try await client
                .from("profiles")
                .select("nickname", head: true, count: .exact)
                .eq("nickname", value: nickname)
                .limit(1)
                .execute()
            let available = (response.count ?? 0) == 0
            if available {
                self.nicknameCheckMessage = "사용 가능한 닉네임입니다."
                self.nicknameAvailable = true
            } else {
                self.nicknameCheckMessage = "이미 사용 중인 닉네임입니다."
                self.nicknameAvailable = false
            }
        } catch {
            self.nicknameCheckMessage = "닉네임 확인 실패: \(error.localizedDescription)"
            self.nicknameAvailable = false
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
            
            // 2) Supabase Auth 회원가입 (이메일 중복 시 여기서 에러 발생)
            let authResponse = try await client.auth.signUp(
                email: email,
                password: password,
                data: [
                    "nickname": .string(nickname),
                    "name": .string(name),
                    "gender": .string(convertedGender)
                ]
            )
            
            // 2) 세션이 있으면 즉시 로그인 상태이므로 DB write 수행
            if let session = authResponse.session {
                let userId = session.user.id.uuidString
                
                try await client
                    .from("profiles")
                    .upsert([
                        "id": userId,
                        "email": email,
                        "nickname": nickname,
                        "name": name,
                        "gender": convertedGender,
                        "type": "user"
                    ], onConflict: "id")
                    .execute()
                
                isSignUpSuccess = true
            }
            // 3) 세션은 없고 user만 있으면(이메일 인증 필요) → 가입 성공 처리만
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
