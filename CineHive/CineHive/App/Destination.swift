//
//  Destination.swift
//  CineHive
//
//  Created by 이종민 on 4/1/25.
//

import SwiftUI

enum Destination: Identifiable, Hashable {
    case splash
    case login
    case signup
    case itemDetails(id: String)
    case moreInfo
    case home
    case welcome
    
    // Identifable 구현
    var id: String { "\(self)" }
    
    // Hashable 구현
    func hash(into haser: inout Hasher) {
        haser.combine(id)
    }
    
    static func == (lhs: Destination, rhs: Destination) -> Bool {
        lhs.id == rhs.id
    }
}
