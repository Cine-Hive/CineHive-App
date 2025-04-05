//
//  YoutubePlayerView.swift
//  CineHive
//
//  Created by 이종민 on 3/6/25.
//

import SwiftUI
import youtube_ios_player_helper

struct YoutubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        
        // 플레이어 설정 - 자동 재생 없이, 컨트롤만 표시
        let playerVars: [AnyHashable: Any] = [
            "playsinline": 1,
            "controls": 1,
            "showinfo": 1,
            "rel": 0,
            "autoplay": 0,
            "modestbranding": 1
        ]
        
        playerView.load(withVideoId: videoID, playerVars: playerVars)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
        // 업데이트가 필요한 경우 여기에 코드 추가
    }
}
