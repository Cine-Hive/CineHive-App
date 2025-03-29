//
//  User+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/27/25.
//

import Foundation

extension User {
    static var dummy1: User {
        User(
            id: 1,
            email: "unib335@naver.com",
            password: "$2a$10$NgKw9sCbuUEa.6Dlj4xKF.4u8XRA9lfEkAfWhWfxYo9kvAcIp7EZy",
            nickname: "lee",
            name: "lee",
            gender: "남자",
            type: "일반"
        )
    }
}
