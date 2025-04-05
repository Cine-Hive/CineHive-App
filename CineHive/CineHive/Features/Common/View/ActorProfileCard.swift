//
//  ActorProfileView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct ActorProfileCard: View {
    let actor: Actor

    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: actor.posterURL) { phase in
                switch phase {
                case .empty:
                    placeholderView
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                case .failure:
                    placeholderView
                @unknown default:
                    placeholderView
                }
            }

            Text(actor.name)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .frame(width: 90)
                .lineLimit(1)

            Text("배우") // 역할이 있다면 변경 가능
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(width: 90)
                .lineLimit(1)
        }
    }

    private var placeholderView: some View {
        Circle()
            .fill(Color.gray.opacity(0.2))
            .frame(width: 80, height: 80)
    }
}

#Preview {
    ActorProfileCard(actor: MovieDetail.dummy.actors!.first!)
        .background(.black)
}
