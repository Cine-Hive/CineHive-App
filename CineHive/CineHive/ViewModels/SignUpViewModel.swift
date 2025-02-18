//
//  SignUpViewModel.swift
//  CineHive
//
//  Created by 존진 on 2/18/25.
//

import Foundation

@Observable
class SignUpViewModel {
    var email: String = ""
    var password: String = ""
    var nickname: String = ""
    var name: String = ""
    var gender: String = ""
    var selectedMan: Bool = false
    var selectedWoman: Bool = false
    var showPassword: Bool = false
    
    // 필수 필드 채워져 있는지 검사
    func isValid() -> Bool {
        return !email.isEmpty && !password.isEmpty && !nickname.isEmpty
    }
    
}
