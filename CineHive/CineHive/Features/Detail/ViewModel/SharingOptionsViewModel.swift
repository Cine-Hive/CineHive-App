//
//  SharingOptionsViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI
import MessageUI

final class SharingOptionsViewModel: ObservableObject {
    @Published var isShowingMessageView = false
    @Published var isShowingShareSheet = false
    @Published var showToast = false
    @Published var toastMessage = ""
    
    let movie: MovieDetail
    
    init(movie: MovieDetail) {
        self.movie = movie
    }
    
    func copyURL() {
        let movieURL = "https://cinehive.app/movies/\(movie.id)"
        UIPasteboard.general.string = movieURL
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        showToastWith(message: "URL이 복사되었습니다")
    }
    
    func shareWithKakaoTalk() {
        // 카카오톡 공유 로직 구현 (KakaoSDK 사용)
        // 실패 시 showToastWith(message:) 를 호출하여 사용자에게 알림
    }
    
    func sendMessage() {
        if MFMessageComposeViewController.canSendText() {
            isShowingMessageView = true
        } else {
            showToastWith(message: "SMS 서비스를 사용할 수 없습니다.")
        }
    }
    
    func systemShare() {
        isShowingShareSheet = true
    }
    
    private func showToastWith(message: String) {
        toastMessage = message
        showToast = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
}
