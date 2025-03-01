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
    
    // 로그인
    func login() async {
        let loginData = LoginUser(email: email, password: password)
        
        do {
            let response: LoginResponse = try await UserService.shared.loginUser(user: loginData)
            print("로그인 성공: \(response.message)")
        } catch {
            print("로그인 실패: \(error.localizedDescription)")
        }
    }
}
