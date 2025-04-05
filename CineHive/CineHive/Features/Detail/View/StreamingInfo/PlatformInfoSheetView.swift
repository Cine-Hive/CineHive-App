//
//  PlatformInfoSheetView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct PlatformInfoSheetView: View {
    let movie: MovieDetail
    let onDismiss: () -> Void
    @StateObject private var viewModel: PlatformInfoSheetViewModel

    init(movie: MovieDetail, onDismiss: @escaping () -> Void) {
        self.movie = movie
        self.onDismiss = onDismiss
        _viewModel = StateObject(wrappedValue: PlatformInfoSheetViewModel(movie: movie))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            header
            Rectangle()
                .fill(PlatformInfoSheetTheme.divider)
                .frame(height: 1)
                .padding(.vertical, 4)
            
            if viewModel.platforms.isEmpty {
                EmptyPlatformsView()
            } else {
                AvailablePlatformsView(platforms: viewModel.platforms)
            }
            
            RentalPurchaseInfoView()
            
            infoDisclaimer
            Spacer()
        }
        .padding(20)
        .background(PlatformInfoSheetTheme.background)
    }
    
    private var header: some View {
        HStack {
            Text(movie.title)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(PlatformInfoSheetTheme.text)
                .lineLimit(1)
            
            Spacer()
            
            Button(action: onDismiss) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(PlatformInfoSheetTheme.secondaryText)
                    .font(.title2)
            }
        }
    }
    
    private var infoDisclaimer: some View {
        HStack {
            Image(systemName: "info.circle")
                .foregroundColor(PlatformInfoSheetTheme.accent)
                .font(.system(size: 14))
            
            Text("가격 정보는 변경될 수 있습니다.\n구매 전 해당 서비스에서 최신 정보를 확인하세요.")
                .font(.caption)
                .foregroundColor(PlatformInfoSheetTheme.secondaryText)
        }
        .padding(.top, 8)
        .padding(.bottom, 12)
    }
}

#Preview {
    // 더미 영화 데이터 생성
    let dummyMovie = MovieDetail.dummy
    
    return ZStack {
        PlatformInfoSheetView(movie: dummyMovie, onDismiss: {})
    }
}
