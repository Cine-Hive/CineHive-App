//
//  CineHiveApp.swift
//  CineHive
//
//  Created by 이종민 on 2/16/25.
//

import SwiftUI

@main
struct CineHiveApp: App {
    @State private var userState = UserState.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userState)
        }
    }
}
