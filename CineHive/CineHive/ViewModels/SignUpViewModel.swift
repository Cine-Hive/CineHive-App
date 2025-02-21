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
            if isValidEmail(email) {
                checkValidateEmail()
            }
            validateEmail()
        }
    }
    var password: String = ""
    var nickname: String = "" {
        didSet {
            if nickname.count >= 1 {
                validateNickname()  // 닉네임 입력 변경때마다 검사
            } else {
                nicknameErrorMessage = nil
            }
        }
    }
    var name: String = ""
    var selectedGender: String = ""
    var showPassword: Bool = false
    var emailErrorMessage: String? = nil // 이메일 오류 메시지
    var nicknameErrorMessage: String? = nil
    var nicknameAvailable: Bool = false
    var emailAvailable: Bool = false
    var emailCheckMessage: String? = nil
    
    // 필수 필드 채워져 있는지 검사 및 닉네임 중복검사 결과 값에 따른 회원가입 버튼 활성화
    func isValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && !nickname.isEmpty && isValidEmail(email) && nicknameAvailable
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
    
    // 이메일 중복 검사
    func checkValidateEmail() {
        guard let url = URL(string: "http://localhost:8081/checkemail/\(email)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data,
                  let isAvailable = try? JSONDecoder().decode(Bool.self, from: data) else {
                print("잘못된 응답입니다.")
                return
            }
            
            if isAvailable {
                self.emailCheckMessage = "사용 가능한 이메일입니다."
                self.emailAvailable = true
            } else {
                self.emailCheckMessage = "이미 사용 중인 이메일입니다."
                self.emailAvailable = false
            }
        }
        task.resume()
    }
    
    // 닉네임 중복 검사
    func validateNickname() {
        guard let url = URL(string: "http://localhost:8081/checknickname/\(nickname)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let data = data,
                  let isAvailable = try? JSONDecoder().decode(Bool.self, from: data) else {
                self.nicknameErrorMessage = "잘못된 응답입니다."
                return
            }
            
            if isAvailable {
                self.nicknameErrorMessage = "사용 가능한 닉네임입니다."
                self.nicknameAvailable = true
            } else {
                self.nicknameErrorMessage = "이미 사용 중인 닉네임입니다."
                self.nicknameAvailable = false
            }
        }
        task.resume()
    }
}
