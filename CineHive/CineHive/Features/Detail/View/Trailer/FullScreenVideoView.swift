//
//  FullScreenVideoView.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct FullScreenVideoView: View {
    let videoID: String
    let onClose: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            YoutubePlayerView(videoID: videoID)
            VStack {
                HStack {
                    Spacer()
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}
