//
//  LoginViewController.swift
//  CineHive
//
//  Created by 존진 on 10/16/25.
//

import Foundation
import UIKit

final class LoginViewController: UIViewController {
    private let viewModel = GoogleLoginViewModel()

    @IBAction func didTapGoogleLogin(_ sender: UIButton) {
        Task { @MainActor in
            await viewModel.googleSignIn(from: self)
            if viewModel.shouldNavigateToMain {
                // 메인 화면으로 전환
            } else if viewModel.toast.isShowing {
                // 토스트/알럿 표시
            }
        }
    }
}
