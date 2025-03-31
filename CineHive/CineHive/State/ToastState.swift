//
//  ToastState.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import Foundation

struct ToastState {
    var isShowing = false
    var message = ""
    var type: ToastType = .info
}
