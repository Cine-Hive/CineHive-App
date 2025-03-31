//
//  Router.swift
//  CineHive
//
//  Created by 이종민 on 4/1/25.
//

import SwiftUI
import Observation

@Observable
class Router {
    var root: Destination
    var path: [Destination] = []
    var sheet: Destination?
    var fullScreenCover: Destination?
    
    init(root: Destination) {
        self.root = root
    }
    
    // 루트 화면 전환
    func switchRoot(_ root: Destination, animation: Bool = true) {
        perform(animation: animation) {
            path.removeAll()
            self.root = root
        }
    }
    
    // 새 화면 푸시
    func push(_ destination: Destination, animation: Bool = true) {
        perform(animation: animation) {
            path.append(destination)
        }
    }
    
    // 뒤로 가기
    func pop(animation: Bool = true) {
        perform(animation: animation) {
            if !path.isEmpty {
                path.removeLast()
            }
        }
    }
    
    // 특정 화면으로 돌아가기
    func popTo(_ destination: Destination, animation: Bool = true) {
        guard let index = path.lastIndex(where: { $0 == destination }) else { return }
        perform(animation: animation) {
            path = Array(path[..<(index + 1)])
        }
    }
    
    // 루트로 돌아가기
    func popToRoot(animation: Bool = true) {
        perform(animation: animation) {
            path.removeAll()
        }
    }
    
    // 시트 표시
    func showSheet(_ destination: Destination, animation: Bool = true) {
        perform(animation: animation) {
            sheet = destination
        }
    }
    
    // 전체 화면 커버 표시
    func showFullScreenCover(_ destination: Destination, animation: Bool = true) {
        perform(animation: animation) {
            fullScreenCover = destination
        }
    }
    
    // 시트나 전체 화면 닫기
    func dismiss(animation: Bool = true) {
        perform(animation: animation) {
            if sheet != nil {
                sheet = nil
            } else if fullScreenCover != nil {
                fullScreenCover = nil
            }
        }
    }
    
    // 애니메이션 제어
    private func perform(animation: Bool, block: () -> Void) {
        if !animation {
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                block()
            }
        } else {
            block()
        }
    }
}
