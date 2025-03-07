//
//  DetailActorsView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailActorsView: View {
    let actors: [Actor]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("출연 배우")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.top, 8)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(actors) { actor in
                        ActorProfileView(actor: actor)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
        .background(Color.black)
    }
}

// MARK: - 프리뷰
#Preview {
    DetailActorsView(actors: [Actor.dummy, Actor.dummy2])
        .background(Color.black)
}
