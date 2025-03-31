//
//  LoginViewModel.swift
//  CineHive
//
//  Created by 존진 on 3/1/25.
//

import Foundation

@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var showPassword: Bool = false
    
    var isLoggingIn: Bool = false
    var errorMessage: String? = nil

    private let emailValidator: (String) -> Bool = { email in
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }

    @MainActor
    func login(router: AppRouter) async {
        guard !email.isEmpty else {
            errorMessage = "이메일을 입력해주세요."
            return
        }
        guard !password.isEmpty else {
            errorMessage = "비밀번호를 입력해주세요."
            return
        }
        if !emailValidator(email) {
            errorMessage = "올바른 이메일 형식이 아닙니다."
            return
        }

        isLoggingIn = true
        errorMessage = nil

        let success = await UserState.shared.login(email: email, password: password)

        isLoggingIn = false

        if success {
            router.goToMain()
        } else {
            errorMessage = UserState.shared.errorMessage ?? "로그인에 실패했습니다."
        }
    }

    @MainActor
    func socialLogin(provider: SocialLoginProvider, router: AppRouter) async {
        print("\(provider.rawValue) 로그인 시도")
        // 소셜 로그인 구현 시 router.goToMain() 호출
    }
}
