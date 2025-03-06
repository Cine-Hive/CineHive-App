//
//  DetailActionButtonsView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailActionButtonsView: View {
    let backgroundColor: Color
    let textColor: Color
    
    @State private var isAddedToList: Bool = false
    @State private var isLiked: Bool = false
    @State private var showShareAlert: Bool = false

    var body: some View {
        HStack(spacing: 0) {
            // 내 리스트 버튼
            Button(action: {
                isAddedToList.toggle()
            }) {
                VStack(spacing: 8) {
                    Image(systemName: isAddedToList ? "checkmark" : "plus")
                        .font(.system(size: 18))
                    Text(isAddedToList ? "추가됨" : "내 리스트")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }

            // 평가 버튼 (좋아요 / 취소)
            Button(action: {
                isLiked.toggle()
            }) {
                VStack(spacing: 8) {
                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .font(.system(size: 18))
                    Text(isLiked ? "좋아요 취소" : "좋아요")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }

            // 공유 버튼
            Button(action: {
                copyToClipboard(text: "CineHive - 영화 공유하기")
                showShareAlert = true
            }) {
                VStack(spacing: 8) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 18))
                    Text("공유")
                        .font(.system(size: 12))
                }
                .frame(maxWidth: .infinity)
            }
            .alert(isPresented: $showShareAlert) {
                Alert(title: Text("공유 완료"), message: Text("영화 링크가 복사되었습니다."), dismissButton: .default(Text("확인")))
            }
        }
        .foregroundColor(textColor)
        .padding(.vertical, 16)
        .background(backgroundColor)
    }

    // 클립보드에 텍스트 복사하는 함수
    private func copyToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
}

// MARK: - 프리뷰
#Preview {
    DetailActionButtonsView(backgroundColor: .black, textColor: .white)
}
