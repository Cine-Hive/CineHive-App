//
//  AdditionalInfoView.swift
//  CineHive
//
//  Created by 존진 on 3/10/25.
//

import SwiftUI
import PhotosUI

struct AdditionalInfoView: View {
    
    @State var viewModel = AdditionalInfoViewModel()
    @State private var isShowingView = false
    @State private var currentPage: Int = 0

    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                // 인디케이터
                HStack(spacing: 8) {
                    ForEach(0..<4) { index in
                        Circle()
                            .fill(currentPage == index ? CHColors.Button.primary : Color.gray.opacity(0.4))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 18)
                Spacer()
                TabView(selection: $currentPage) {
                    ProfileSelectedView()
                        .tag(0)
                    GenreSelectedView()
                        .tag(1)
                    ServiceSelectedView()
                        .tag(2)
                    RegionSelectedView()
                        .tag(3)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: UIScreen.main.bounds.height * 0.75)
                Spacer()
                // 하단 버튼
                HStack {
                    Spacer()
                    Button(action: {
                        if currentPage < 3 {
                            currentPage += 1
                        } else {
                            isShowingView = true
                        }
                    }, label: {
                        Text("건너 뛰기")
                            .frame(width: 140, height: 50)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.white, lineWidth: 1)
                            )
                    })
                    .fullScreenCover(isPresented: $isShowingView) {
                        MainTabView()
                    }
                    Button(action: {
                        if currentPage < 3 {
                            currentPage += 1
                        } else {
                            isShowingView = true
                        }
                    }, label: {
                        Text(currentPage < 3 ? "다음으로" : "완료")
                            .frame(width: 180, height: 50)
                            .font(.system(size: 17, weight: .semibold))
                            .background(viewModel.isSelectionValid() ? CHColors.Button.primary : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                    .foregroundStyle(.white)
                    .disabled(!viewModel.isSelectionValid())
                    .fullScreenCover(isPresented: $isShowingView) {
                        MainTabView()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct InfoStepContainer<Content: View>: View {
    let title: String
    let subtitle: String
    let content: () -> Content

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundStyle(.white)
                Text(subtitle)
                    .font(.system(size: 16, weight: .light))
                    .foregroundStyle(.white)
                    .padding(.top, 10)
            }
            .padding(.top, 100)
            content()
                .padding(.bottom, 10)
            Spacer()
        }
        .frame(maxWidth: 330)
    }
}

#Preview {
    AdditionalInfoView()
}
