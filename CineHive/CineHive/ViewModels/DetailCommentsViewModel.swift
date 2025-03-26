//
//  DetailCommentsViewModel.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

@Observable
class DetailCommentsViewModel {
    var reviews: [Review] = [
        Review(username: "영화광", rating: 4.5, comment: "정말 재미있게 봤습니다!", likes: 3),
        Review(username: "시네필", rating: 5.0, comment: "기대 이상이었어요!", likes: 5),
        Review(username: "무비로버", rating: 3.8, comment: "영상미가 아름다웠어요.", likes: 2)
    ]
    
    var isAddingReview = false
    var newReviewText = ""
    var newRating: Double = 4.0

    func addReview() {
        guard !newReviewText.isEmpty else { return }
        let newReview = Review(username: "사용자", rating: newRating, comment: newReviewText, likes: 0)
        reviews.append(newReview)
        resetReviewForm()
    }

    func resetReviewForm() {
        newReviewText = ""
        newRating = 4.0
        isAddingReview = false
    }
}
