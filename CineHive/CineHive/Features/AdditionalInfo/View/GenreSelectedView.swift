//
//  GenreSelectedView.swift
//  CineHive
//
//  Created by 존진 on 3/27/25.
//

import SwiftUI

struct GenreSelectedView: View {
    @Bindable var viewModel = AdditionalInfoViewModel()
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                InfoStepContainer(
                    title: "선호하는 장르를 선택해보세요!",
                    subtitle: "취향에 맞는 콘텐츠를 제공해드릴게요") {
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(viewModel.genres, id: \.self) { genres in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(viewModel.selectedGenres.contains(genres) ? CHColors.Button.primary : Color.white, lineWidth: 1)
                                    .background(
                                        viewModel.selectedGenres.contains(genres) ? CHColors.Button.primary.opacity(0.1) : Color.background
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: 105, height: 95)
                                Text(genres)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(viewModel.selectedGenres.contains(genres) ? CHColors.Button.primary : Color.white)
                            }
                            .padding(.top, 10)
                            .onTapGesture {
                                if viewModel.selectedGenres.contains(genres) {
                                    viewModel.selectedGenres.remove(genres)
                                } else {
                                    viewModel.selectedGenres.insert(genres)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
#Preview {
    GenreSelectedView()
}
