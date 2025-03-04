//
//  DetailTrailersView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailTrailersView: View {
    let videos: [Video]

    @State private var showTrailer: Bool = false
    @State private var selectedTrailer: Video?

    private let textColor = Color.white

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("예고편 및 관련 영상")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(textColor)
                .padding(.horizontal, 16)
                .padding(.top, 8)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(videos) { video in
                        Button(action: {
                            selectedTrailer = video
                            showTrailer = true
                        }) {
                            ZStack(alignment: .center) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 280, height: 160)
                                    .cornerRadius(8)
                                
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 42))
                                    .foregroundColor(textColor.opacity(0.8))
                            }
                            .overlay(
                                VStack(alignment: .leading) {
                                    Spacer()
                                    Text(video.name)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(textColor)
                                        .padding(8)
                                        .lineLimit(1)
                                }
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(4),
                                alignment: .bottom
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .fullScreenCover(isPresented: $showTrailer) {
            if let selectedTrailer = selectedTrailer {
                TrailerPlayerView(trailerURL: URL(string: "https://www.youtube.com/watch?v=\(selectedTrailer.videoKey)")!)
            }
        }
    }
}

#Preview {
    DetailTrailersView(
        videos: [Video.dummy, Video.dummy2, Video.dummy3, Video.dummy4, Video.dummy5]
    )
    .background(.black)
}
