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
    let movie: MovieDetail
    
    @Bindable private var viewModel = DetailActionButtonsViewModel()
    @State private var showShareSheetState: Bool = false
    
    
    var body: some View {
        HStack(spacing: 0) {
            // 관심목록 버튼
            ActionButton(
                imageName: viewModel.isAddedToList ? "checkmark" : "plus",
                text: viewModel.isAddedToList ? "추가됨" : "관심목록",
                textColor: textColor,
                isActive: viewModel.isAddedToList,
                action: viewModel.toggleWatchlist
            )
            
            // 시청 정보 버튼
            ActionButton(
                imageName: "tv",
                text: "시청 정보",
                textColor: textColor,
                action: viewModel.openAvailabilitySheet
            )
            .sheet(isPresented: $viewModel.showAvailabilitySheet) {
                PlatformInfoSheetView(
                    movie: movie,
                    onDismiss: viewModel.closeAvailabilitySheet
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
            
            // 공유 버튼 - 커스텀 공유 시트 표시
            ActionButton(
                imageName: "square.and.arrow.up",
                text: "공유",
                textColor: textColor,
                action: {
                    viewModel.openShareSheet()
                    showShareSheetState = true
                }
            )
            .sheet(isPresented: $showShareSheetState, onDismiss: {
                viewModel.closeShareSheet()
            }) {
                CustomShareSheetView(movie: movie)
                    .presentationDetents([.fraction(0.5)])
                    .presentationDragIndicator(.visible)
            }
        }
        .padding(.vertical, 16)
        .background(backgroundColor)
    }
}

// MARK: - 프리뷰
#Preview {
    return DetailActionButtonsView(
        backgroundColor: .black,
        textColor: .white,
        movie: MovieDetail.dummy
    )
}
