//
//  DetailTrailersView.swift
//  CineHive
//
//  Created by 이종민 on 3/5/25.
//

import SwiftUI
import OSLog
import youtube_ios_player_helper

struct DetailTrailersView: View {
    let videos: [Video]
    @State private var selectedVideoID: String?
    @State private var showTrailer: Bool = false
    
    private let textColor = Color.white
    private let secondaryTextColor = Color.gray
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("관련 영상")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(videos) { video in
                        VStack {
                            YoutubePlayerView(videoID: video.videoKey)
                                .frame(width: 280, height: 160)
                                .cornerRadius(4)
                                .onTapGesture {
                                    selectedVideoID = video.videoKey
                                    showTrailer = true
                                    Logger.log(.info, category: .ui, message: "선택된 비디오 ID: \(video.videoKey)")
                                }
                            Text(video.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(textColor)
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    DetailTrailersView(
        videos: [Video.dummy, Video.dummy2, Video.dummy3, Video.dummy4, Video.dummy5]
    )
    .background(.black)
}
