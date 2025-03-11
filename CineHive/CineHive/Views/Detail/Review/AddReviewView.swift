//
//  AddReviewView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct AddReviewView: View {
    @Bindable var viewModel: DetailCommentsViewModel
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isTextFieldFocused: Bool
    
    // 테마 색상
    private struct Theme {
        static let background = Color.black
        static let text = Color.white
        static let secondaryText = Color.gray
        static let accent = Color.red
        static let inputBackground = Color(white: 0.15)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // 헤더
            HStack {
                Text("리뷰 작성")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(Theme.secondaryText)
                }
            }
            .padding(.bottom, 8)
            
            // 별점 선택 UI
            VStack(alignment: .leading, spacing: 8) {
                Text("별점")
                    .font(.headline)
                    .foregroundColor(Theme.text)
                
                HStack(spacing: 0) {
                    ForEach(1...5, id: \.self) { index in
                        starButton(index: index)
                    }
                    
                    Text(String(format: "%.1f", viewModel.newRating))
                        .font(.headline)
                        .foregroundColor(Theme.accent)
                        .frame(width: 40, alignment: .trailing)
                        .padding(.leading, 8)
                }
            }
            
            // 리뷰 텍스트 필드
            VStack(alignment: .leading, spacing: 8) {
                Text("내용")
                    .font(.headline)
                    .foregroundColor(Theme.text)
                
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $viewModel.newReviewText)
                        .focused($isTextFieldFocused)
                        .scrollContentBackground(.hidden)
                        .background(Theme.inputBackground)
                        .foregroundColor(Theme.text)
                        .cornerRadius(8)
                        .frame(minHeight: 120)
                        .padding(1) // 테두리를 위한 패딩
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isTextFieldFocused ? Theme.accent : Theme.secondaryText.opacity(0.3), lineWidth: 1)
                        )
                    
                    if viewModel.newReviewText.isEmpty && !isTextFieldFocused {
                        Text("영화에 대한 리뷰를 작성해주세요...")
                            .foregroundColor(Theme.secondaryText)
                            .padding(8)
                    }
                }
            }
            
            Spacer()
            
            // 등록 버튼
            Button(action: {
                viewModel.addReview()
                dismiss()
            }) {
                Text("리뷰 등록하기")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        viewModel.newReviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
                            Theme.secondaryText : Theme.accent
                    )
                    .cornerRadius(12)
                    .shadow(color: Theme.accent.opacity(0.3), radius: 5, x: 0, y: 2)
            }
            .disabled(viewModel.newReviewText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
        .padding(20)
        .background(Theme.background.edgesIgnoringSafeArea(.all))
        .onAppear {
            // 화면이 나타날 때 키보드 자동 표시
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isTextFieldFocused = true
            }
        }
    }
    
    // 별점 버튼 생성 함수
    private func starButton(index: Int) -> some View {
        let isFilled = viewModel.newRating >= Double(index) - 0.25
        let isHalfFilled = viewModel.newRating >= Double(index) - 0.75 && viewModel.newRating < Double(index) - 0.25
        
        return Button(action: {
            viewModel.newRating = Double(index)
        }) {
            Image(systemName: isFilled ? "star.fill" : (isHalfFilled ? "star.leadinghalf.filled" : "star"))
                .font(.title3)
                .foregroundColor(Theme.accent)
        }
        .buttonStyle(StarButtonStyle())
    }
}

// 별점 버튼 스타일
struct StarButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(5)
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview {
    AddReviewView(viewModel: DetailCommentsViewModel())
        .background(Color.black)
}
