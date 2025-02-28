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
                Task {
                    await checkValidateEmail()
                }
            }
            validateEmail()
        }
    }
    var password: String = ""
    var nickname: String = "" {
        didSet {
            if nickname.count >= 1 {
                Task {
                    await validateNickname()  // 닉네임 입력 변경때마다 검사
                }
            } else {
                nicknameErrorMessage = nil
            }
        }
    }
    var name: String = ""
    var gender: String = ""
    var showPassword: Bool = false
    var emailErrorMessage: String? = nil // 이메일 오류 메시지
    var nicknameErrorMessage: String? = nil
    var nicknameAvailable: Bool = false
    var emailAvailable: Bool = false
    var emailCheckMessage: String? = nil
    var isSignUpSuccess: Bool = false
    private let userService: UserService
    
    init(userService: UserService = .shared) {
        self.userService = userService
    }
    
    // 필수 필드 채워져 있는지 검사 및 닉네임 중복검사 결과 값에 따른 회원가입 버튼 활성화
    func isValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && !nickname.isEmpty && isValidEmail(email) && nicknameAvailable && emailAvailable
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
    @MainActor
    func checkValidateEmail() async {
        do {
            let isAvailable = try await userService.fetchUserEmail(email: email)
            if isAvailable {
                self.emailCheckMessage = "사용 가능한 이메일입니다."
                self.emailAvailable = true
            } else {
                self.emailCheckMessage = "이미 사용 중인 이메일입니다."
                self.emailAvailable = false
            }
        } catch {
            self.emailErrorMessage = "이메일 중복 검사 실패: \(error.localizedDescription)"
            self.emailAvailable = false
        }
    }
    
    // 닉네임 중복 검사
    @MainActor
    func validateNickname() async {
        do {
            let isAvailable = try await userService.fetchUserNickname(nickname: nickname)
            if isAvailable {
                self.nicknameErrorMessage = "사용 가능한 닉네임입니다."
                self.nicknameAvailable = true
            } else {
                self.nicknameErrorMessage = "이미 사용 중인 닉네임입니다."
                self.nicknameAvailable = false
            }
        } catch {
            self.nicknameErrorMessage = "닉네임 중복 검사 실패: \(error.localizedDescription)"
            self.nicknameAvailable = false
        }
    }
    
    // 회원가입
    @MainActor
    func signUp() async {
        
        let newUser = User(
            email: email,
            password: password,
            nickname: nickname,
            name: name.isEmpty ? nil : name,
            gender: gender.isEmpty ? nil : gender,
            type: "일반"
        )
        
        // newUser 객체 -> JSON으로 변환되는지
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            _ = try encoder.encode(newUser)
        } catch {
            print("JSON 변환 실패: \(error)")
        }
        
        do {
            let response = try await UserService.shared.registerUser(user: newUser)
            print("서버 응답 메시지: \(response.message), 상태: \(response.status)")
            
            if response.status == "success" {
                self.isSignUpSuccess = true // 회원가입 성공 후 로그인 화면으로 이동
            }
        } catch {
            print("회원가입 실패: \(error.localizedDescription)")
        }
    }
}
