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
                        VStack(spacing: 8) {
                            if let url = actor.posterURL {
                                AsyncImage(url: url) { phase in
                                    switch phase {
                                    case .empty:
                                        Circle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    case .failure:
                                        Circle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                    @unknown default:
                                        Circle()
                                            .fill(Color.gray.opacity(0.2))
                                            .frame(width: 80, height: 80)
                                    }
                                }
                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 80, height: 80)
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
