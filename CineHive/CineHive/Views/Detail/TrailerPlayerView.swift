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

    @StateObject private var player = AVPlayerWrapper()
    @Environment(\.dismiss) private var dismiss  // 최신 dismiss 방식 적용
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VideoPlayer(player: player.player)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    player.play(url: trailerURL)
                    observePlayerEnd()
                }
            
            // 닫기 버튼
            Button(action: {
                closePlayer()
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

    // MARK: - 플레이어 종료 감지
    private func observePlayerEnd() {
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.player.currentItem,
            queue: .main
        ) { _ in
            closePlayer()  // 영상 종료 후 자동 닫기
        }
    }

    // MARK: - 닫기 기능
    private func closePlayer() {
        player.stop()
        dismiss()
    }
}

// MARK: - AVPlayer 관리 클래스 (반복 생성 방지 + 자동 종료 처리)
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

// MARK: - 프리뷰 (YouTube URL 대신 MP4 테스트 URL 사용 가능)
#Preview {
    TrailerPlayerView(trailerURL: URL(string: "https://www.youtube.com/watch?v=9kPhqnqUYz4")!)
}
