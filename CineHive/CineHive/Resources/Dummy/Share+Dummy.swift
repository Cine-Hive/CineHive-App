//
//  Share+Dummy.swift
//  CineHive
//
//  Created by 이종민 on 3/8/25.
//

import SwiftUI

extension Share {
    static let dummyList: [Share] = ShareOption.allCases.map { option in
        Share(title: option.title,
              icon: option.icon,
              shareOption: option,
              color: option.color,
              highlightColor: option.highlightColor)
    }
    
    static var dummy: Share {
        dummyList.first ?? Share(title: "메시지", icon: "message.fill", shareOption: .message, color: .green, highlightColor: .green)
    }
}
