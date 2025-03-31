//
//  AppRouter.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import Foundation
import Observation

@Observable
class AppRouter {
    var currentFlow: AppFlow = .auth
    
    // 인증
    func goToAuth() { currentFlow = .auth }
    func goToLogin() { currentFlow = .login }
    func goToSignUp() { currentFlow = .signUp }
    func goToOnboarding() { currentFlow = .onboarding }
    
    // 메인
    func goToMain() { currentFlow = .main }
}
