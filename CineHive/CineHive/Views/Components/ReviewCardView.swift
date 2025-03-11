//
//  ReviewCardView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct ReviewCardView: View {
    @Binding var review: Review
    private let textColor = Color.white
    private let secondaryTextColor = Color.gray

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(secondaryTextColor)

                VStack(alignment: .leading, spacing: 4) {
                    Text(review.username)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(textColor)

                    HStack {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= Int(review.rating) ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundColor(i <= Int(review.rating) ? .yellow : secondaryTextColor)
                        }
                        
                        Text("• \(Int.random(in: 1...12))일 전")
                            .font(.system(size: 12))
                            .foregroundColor(secondaryTextColor)
                    }
                }

                Spacer()

                Button(action: {
                    review.likes += 1
                }) {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .font(.system(size: 14))
                        Text("\(review.likes)")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(secondaryTextColor)
                }
            }

            Text(review.comment)
                .font(.system(size: 15))
                .lineSpacing(4)
                .foregroundColor(textColor.opacity(0.9))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ReviewCardView(review: .constant(Review(
        username: "이종민",
        rating: 4.5,
        comment: "정말 재미있게 봤습니다!",
        likes: 10
    )))
    .background(Color.black)
}
