//
//  DetailCommentsView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailCommentsView: View {
    private let textColor = Color.white
    private let secondaryTextColor = Color.gray
    private let accentColor = Color.red

    @Bindable private var viewModel = DetailCommentsViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("시청자 리뷰")
                    .font(.system(size: 18, weight: .bold))

                Spacer()

                Button(action: {
                    viewModel.isAddingReview = true
                }) {
                    Text("리뷰 작성")
                        .font(.system(size: 14))
                        .foregroundColor(accentColor)
                }
            }
            .padding(.horizontal, 16)

            ForEach($viewModel.reviews) { $review in
                ReviewCardView(review: $review)
            }
        }
        .sheet(isPresented: $viewModel.isAddingReview) {
            AddReviewView(viewModel: viewModel)
        }
    }
}

// MARK: - 프리뷰
#Preview {
    DetailCommentsView()
        .background(.black)
}
