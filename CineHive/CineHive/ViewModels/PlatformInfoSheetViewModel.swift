//
//  PlatformInfoSheetViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

final class PlatformInfoSheetViewModel: ObservableObject {
    let movie: MovieDetail
    @Published var platforms: [StreamingPlatform] = []
    
    init(movie: MovieDetail) {
        self.movie = movie
        loadPlatforms()
    }
    
    private func loadPlatforms() {
        // 영화 아이디에 해당하는 스트리밍 플랫폼 목록을 불러옵니다.
        platforms = StreamingPlatform.getPlatformsForMovie(id: movie.id)
    }
}
