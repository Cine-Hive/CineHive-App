//
//  User.swift
//  CineHive
//
//  Created by 존진 on 2/22/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int?
    let email: String
    let password: String
    let nickname: String
    let name: String?
    let gender: String?
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "mem_id"
        case email = "memEmail"
        case password = "memPassword"
        case nickname = "memNickname"
        case name = "memName"
        case gender = "memSex"
        case type = "memType"
    }
    
    // 기본 생성자
    init(id: Int? = nil, email: String, password: String, nickname: String, name: String?, gender: String?, type: String) {
        self.id = id
        self.email = email
        self.password = password
        self.nickname = nickname
        self.name = name
        self.gender = gender
        self.type = type
    }
}
