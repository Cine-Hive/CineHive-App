//
//  TrailerPlayerView.swift
//  CineHive
//
//  Created by 이종민 on 3/5/25.
//

import SwiftUI
import youtube_ios_player_helper

struct TrailerPlayerView: View {
    let videoID: String
    @Environment(\.dismiss) private var dismiss  // 최신 dismiss 방식 적용

    var body: some View {
        ZStack(alignment: .topTrailing) {
            YouTubePlayer(videoID: videoID)
                .edgesIgnoringSafeArea(.all)
            
            // 닫기 버튼
            Button(action: {
                dismiss()
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

// MARK: - UIKit 기반 YouTube Player 뷰
struct YouTubePlayer: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID, playerVars: ["playsinline": 1])
        return playerView
    }

    func updateUIView(_ uiView: YTPlayerView, context: Context) {}
}

// MARK: - Preview
#Preview {
    TrailerPlayerView(videoID: "3x6nwhsEuBo") // 예시 YouTube 영상 ID
}
