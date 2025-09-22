//
//  LoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 3/1/25.
//

import Foundation
import Supabase

@Observable
class LoginViewModel {
    // 입력 필드
    var email: String = ""
    var password: String = ""
    var showPassword: Bool = false
    
    // 상태
    var isLoggingIn: Bool = false
    var navigateToHome: Bool = false
    var errorMessage: String? = nil
    var shouldOfferEmailVerificationResend: Bool = false
    
    // 이메일 유효성 검사기
    private let emailValidator: (String) -> Bool = { email in
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // 로그인
    @MainActor
    func login() async {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 입력 유효성 검사
        guard !trimmedEmail.isEmpty else {
            errorMessage = "이메일을 입력해주세요."
            return
        }
        
        guard !trimmedPassword.isEmpty else {
            errorMessage = "비밀번호를 입력해주세요."
            return
        }
        
        if !emailValidator(trimmedEmail) {
            errorMessage = "올바른 이메일 형식이 아닙니다."
            return
        }
        
        isLoggingIn = true
        defer { isLoggingIn = false }
        errorMessage = nil
        
        do {
            _ = try await SupabaseConfig.shared.client.auth.signIn(email: trimmedEmail, password: trimmedPassword)
            navigateToHome = true
        } catch {
            let nsError = error as NSError
            let code = nsError.code
            let raw = String(describing: error).lowercased()
            if raw.contains("email_not_confirmed") || raw.contains("email not confirmed") {
                shouldOfferEmailVerificationResend = true
            } else if code == 429 {
                errorMessage = "요청이 너무 많습니다. 잠시 후 다시 시도해주세요."
                shouldOfferEmailVerificationResend = false
            } else if code == -1009 {
                errorMessage = "네트워크 연결을 확인해주세요."
                shouldOfferEmailVerificationResend = false
            } else if code == 400 {
                errorMessage = "이메일 또는 비밀번호를 다시 확인해주세요."
                shouldOfferEmailVerificationResend = false
            } else {
                errorMessage = "로그인 중 오류가 발생했습니다. 다시 시도해주세요."
                shouldOfferEmailVerificationResend = false
            }
        }
    }
    
    // 소셜 로그인
    @MainActor
    func socialLogin(provider: SocialLoginProvider) async {
        // 소셜 로그인 구현 (향후 확장)
        print("\(provider.rawValue) 로그인 시도")
    }
}
