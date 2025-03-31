//
//  RoutingView.swift
//  CineHive
//
//  Created by 이종민 on 4/1/25.
//

import SwiftUI

struct RoutingView: View {
    @State private var router: Router
    
    init(root: Destination) {
        _router = State(initialValue: Router(root: root))
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            destinationView(for: router.root)
                .navigationDestination(for: Destination.self) { destination in
                    destinationView(for: destination)
                }
        }
        .environment(router)
        .sheet(item: $router.sheet) { destination in
            destinationView(for: destination)
        }
        .fullScreenCover(item: $router.fullScreenCover) { destination in
            destinationView(for: destination)
        }
    }
    
    @ViewBuilder
    func destinationView(for destination: Destination) -> some View {
        switch destination {
        case .welcome:
            WelcomeView()
        case .login:
            LoginView()
        case .signup:
            SignUpView()
        case .home:
            HomeTabView()
        }
    }
}
