//
//  UIApplication+Extension.swift
//  CineHive
//
//  Created by 존진 on 5/22/25.
//

import Foundation
import UIKit

extension UIApplication {
    // 현재 앱의 최상위 루트 뷰 컨트롤러를 반환
    func rootViewController() -> UIViewController? {
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?.windows
            .first?.rootViewController
    }
}
