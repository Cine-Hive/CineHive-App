//
//  StreamingPlatform.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct StreamingPlatform: Identifiable {
    let id = UUID()
    let name: String
    let logo: String
    let color: Color
    let price: String
    
    static func getPlatformsForMovie(id: Int) -> [StreamingPlatform] {
        // 영화 ID에 따라 일관된 플랫폼 배열 생성 (같은 영화는 항상 같은 결과)
        let seed = id % 5 + 1
        let priceOptions = ["무료", "구독 필요", "₩4,500", "₩12,000", "₩3,500"]
        
        let allPlatforms = [
            StreamingPlatform(
                name: "Netflix",
                logo: "n.square.fill",
                color: .red,
                price: priceOptions[id % priceOptions.count]
            ),
            StreamingPlatform(
                name: "Disney+",
                logo: "d.square.fill",
                color: .blue,
                price: priceOptions[(id + 1) % priceOptions.count]
            ),
            StreamingPlatform(
                name: "Apple TV+",
                logo: "apple.logo",
                color: .gray,
                price: priceOptions[(id + 2) % priceOptions.count]
            ),
            StreamingPlatform(
                name: "Wavve",
                logo: "w.square.fill",
                color: .blue,
                price: priceOptions[(id + 3) % priceOptions.count]
            ),
            StreamingPlatform(
                name: "Tving",
                logo: "t.square.fill",
                color: .red,
                price: priceOptions[(id + 4) % priceOptions.count]
            )
        ]
        
        return Array(allPlatforms.prefix(seed))
    }
}
