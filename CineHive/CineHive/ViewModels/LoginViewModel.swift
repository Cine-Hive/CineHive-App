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
    var sinupViewModel: SignUpViewModel = SignUpViewModel()
    var showAlert: Bool = false
    var alertMessage: String = ""   // alert에 표시할 메세지
    var errorMessage: String? = nil
    
    // 로그인
    @MainActor
    func login() async {
        let result: Bool = sinupViewModel.isValidEmail(email)     // 이메일 정규식 검사
        
        guard result else {
            errorMessage = "올바른 이메일 형식이 아닙니다."
            return
        }
        
        let loginData = LoginUser(email: email, password: password)
        
        do {
            let response: LoginResponse = try await UserService.shared.loginUser(user: loginData)
            print("로그인 성공: \(response.message)")
        } catch {
            print("로그인 실패: \(error.localizedDescription)")
            self.errorMessage = "일치하는 사용자 정보가 없습니다."
        }
    }
}
