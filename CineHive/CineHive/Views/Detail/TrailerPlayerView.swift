//
//  TrailerPlayerView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI
import AVKit

struct TrailerPlayerView: View {
    let trailerURL: URL
    
    // AVPlayer를 상태 객체로 관리 (반복적인 생성 방지)
    @StateObject private var player = AVPlayerWrapper()
    @Environment(\.dismiss) private var dismiss  // 최신 dismiss 방식 적용

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VideoPlayer(player: player.player)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    player.play(url: trailerURL)  // URL 설정 및 자동 재생
                }
            
            // 닫기 버튼
            Button(action: {
                player.stop()  // 플레이어 중지
                dismiss()  // 화면 닫기
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
                    .padding()
            }
        }
    }
}

// MARK: - AVPlayer 관리 클래스 (반복 생성 방지)
class AVPlayerWrapper: ObservableObject {
    @Published var player: AVPlayer = AVPlayer()

    func play(url: URL) {
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        player.play()
    }

    func stop() {
        player.pause()
        player.replaceCurrentItem(with: nil)
    }
}

// MARK: - 프리뷰 (YouTube URL 대신 MP4 테스트 URL 사용가능)
#Preview {
    TrailerPlayerView(trailerURL: URL(string: "https://www.youtube.com/watch?v=9kPhqnqUYz4")!)
}
