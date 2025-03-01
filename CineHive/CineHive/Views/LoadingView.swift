//
//  LoadingView.swift
//  CineHive
//
//  Created by 이종민 on 3/1/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .padding()
            Text("로딩 중...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    LoadingView()
}
