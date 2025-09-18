//
//  User+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/27/25.
//

import Foundation

extension Profile {
    static var dummy1: Profile {
        Profile(
            id: UUID(),
            email: "unib335@naver.com",
            name: "lee",
            nickname: "lee",
            gender: Profile.Gender.male,
            genres: []
        )
    }
}
