//
//  Banner.swift
//  CineHive
//
//  Created by 이종민 on 2/19/25.
//

import Foundation

struct BannerItem: Identifiable {
    let id = UUID()
    let imageURL: URL?
    let title: String
    let subtitle: String
}
