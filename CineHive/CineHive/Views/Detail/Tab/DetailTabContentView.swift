//
//  DetailTabContentView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailTabContentView: View {
    let movie: MovieDetail
    let selectedTab: DetailTab
    @State var isOverviewExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            switch selectedTab {
            case .overview:
                DetailOverviewView(movie: movie, isExpanded: $isOverviewExpanded)
                if let videos = movie.videos, !videos.isEmpty {
                    DetailTrailersView(
                        videos: videos
                    )
                }
                DetailActorsView(actors: movie.actors)
            case .related:
                DetailRelatedView()
            case .details:
                DetailInfoView(movie: movie)
            case .comments:
                DetailCommentsView()
            }
        }
        .padding(.top, 16)
    }
}

#Preview {
    DetailTabContentView(
        movie: MovieDetail.dummy,
        selectedTab: .overview,
        isOverviewExpanded: false
    ).background(.black)
}
