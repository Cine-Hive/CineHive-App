//
//  Video+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import Foundation

// MARK: - Video 더미 데이터 (YouTube 예고편 링크 활용)
extension Video {
    static var dummy: Video {
        Video(
            id: 1,
            videoKey: "3x6nwhsEuBo",
            name: "인셉션 - 공식 예고편"
        )
    }
    
    static var dummy2: Video {
        Video(
            id: 2,
            videoKey: "EXeTwQWrcwY",
            name: "다크 나이트 - 공식 예고편"
        )
    }
    
    static var dummy3: Video {
        Video(
            id: 3,
            videoKey: "TcMBFSGVi1c",
            name: "어벤져스: 엔드게임 - 공식 예고편"
        )
    }
    
    static var dummy4: Video {
        Video(
            id: 4,
            videoKey: "5PSNL1qE6VY",
            name: "인터스텔라 - 공식 예고편"
        )
    }
    
    static var dummy5: Video {
        Video(
            id: 5,
            videoKey: "6hB3S9bIaco",
            name: "쇼생크 탈출 - 공식 예고편"
        )
    }
}
