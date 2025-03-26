//
//  Banner+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/20/25.
//

import Foundation

// MARK: - Banner 더미 데이터
extension BannerItem {
    static var dummy1: BannerItem {
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w1280/zfbjgQE1uSd9wiPTX4VzsLi0rGG.jpg"),
            title: "쇼생크 탈출",
            subtitle: "희망은 감옥에서도 사라지지 않는다"
        )
    }
    
    static var dummy2: BannerItem {
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w1280/kGzFbGhp99zva6oZODW5atUtnqi.jpg"),
            title: "대부",
            subtitle: "한 가족의 역사, 그리고 조직의 운명"
        )
    }
    
    static var dummy3: BannerItem {
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w1280/hiKmpZMGZsrkA3cdce8a7Dpos1j.jpg"),
            title: "기생충",
            subtitle: "예측할 수 없는 가족의 생존기"
        )
    }
    
    static var dummy4: BannerItem {
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w1280/8sNiAPPYU14PUepFNeSNGUTiHW.jpg"),
            title: "인터스텔라",
            subtitle: "시간과 공간을 초월한 감동의 대서사시"
        )
    }
    
    static var dummy5: BannerItem {
        BannerItem(
            imageURL: URL(string: "https://image.tmdb.org/t/p/w1280/2u7zbn8EudG6kLlBzUYqP8RyFU4.jpg"),
            title: "반지의 제왕: 왕의 귀환",
            subtitle: "모든 것이 결정되는 마지막 전투"
        )
    }
    
    static var dummyBanners: [BannerItem] {
        return [dummy1, dummy2, dummy3, dummy4, dummy5]
    }
}
