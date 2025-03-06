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
    
    @State private var reviews: [Review] = [
        Review(username: "영화광", rating: 4.5, comment: "정말 재미있게 봤습니다!", likes: 3),
        Review(username: "시네필", rating: 5.0, comment: "기대 이상이었어요!", likes: 5),
        Review(username: "무비로버", rating: 3.8, comment: "영상미가 아름다웠어요.", likes: 2)
    ]
    
    @State private var isAddingReview = false
    @State private var newReviewText = ""
    @State private var newRating: Double = 4.0

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("시청자 리뷰")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
                
                Button(action: {
                    isAddingReview = true
                }) {
                    Text("리뷰 작성")
                        .font(.system(size: 14))
                        .foregroundColor(accentColor)
                }
            }
            .padding(.horizontal, 16)
            
            ForEach($reviews) { $review in
                commentView(review: $review)
            }
        }
        .sheet(isPresented: $isAddingReview) {
            addReviewView()
        }
    }
    
    // MARK: - 코멘트 아이템
    private func commentView(review: Binding<Review>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(secondaryTextColor)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(review.username.wrappedValue)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(textColor)
                    
                    HStack {
                        ForEach(1...5, id: \.self) { i in
                            Image(systemName: i <= Int(review.rating.wrappedValue) ? "star.fill" : "star")
                                .font(.system(size: 12))
                                .foregroundColor(i <= Int(review.rating.wrappedValue) ? .yellow : secondaryTextColor)
                        }
                        
                        Text("• \(Int.random(in: 1...12))일 전")
                            .font(.system(size: 12))
                            .foregroundColor(secondaryTextColor)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    review.likes.wrappedValue += 1
                }) {
                    HStack {
                        Image(systemName: "hand.thumbsup")
                            .font(.system(size: 14))
                        Text("\(review.likes.wrappedValue)")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(secondaryTextColor)
                }
            }
            
            Text(review.comment.wrappedValue)
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
    
    // MARK: - 리뷰 추가 화면
    private func addReviewView() -> some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                Text("리뷰 작성")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.horizontal, 16)
                
                TextField("리뷰를 입력하세요...", text: $newReviewText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 16)
                
                HStack {
                    Text("별점:")
                        .font(.system(size: 16))
                    Slider(value: $newRating, in: 1.0...5.0, step: 0.5)
                        .accentColor(accentColor)
                    Text(String(format: "%.1f", newRating))
                        .font(.system(size: 16))
                }
                .padding(.horizontal, 16)
                
                Spacer()
                
                Button(action: {
                    if !newReviewText.isEmpty {
                        let newReview = Review(username: "사용자", rating: newRating, comment: newReviewText, likes: 0)
                        reviews.append(newReview)
                        newReviewText = ""
                        newRating = 4.0
                        isAddingReview = false
                    }
                }) {
                    Text("등록")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(accentColor)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
                
                Button(action: {
                    isAddingReview = false
                }) {
                    Text("취소")
                        .font(.system(size: 16))
                        .foregroundColor(secondaryTextColor)
                }
                .padding(.horizontal, 16)
            }
            .padding(.vertical, 20)
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}

// MARK: - 프리뷰
#Preview {
    DetailCommentsView()
        .background(.black)
}
