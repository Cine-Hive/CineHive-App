//
//  ProfileSelectedView.swift
//  CineHive
//
//  Created by 존진 on 3/27/25.
//

import SwiftUI
import PhotosUI

struct ProfileSelectedView: View {
    @Bindable var viewModel = AdditionalInfoViewModel()
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                InfoStepContainer(title: "프로필을 생성해보세요!", subtitle: "터치해서 프로필을 등록해보세요") {
                    PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                        ZStack {
                            if let image = viewModel.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180, height: 180)
                                    .clipShape(Circle()) // 원형 이미지
                            } else {
                                Circle()
                                    .stroke(Color.white, lineWidth: 1) // 회색 테두리
                                    .frame(width: 180, height: 180)
                                    .overlay(
                                        Image(systemName: "camera") // SF Symbol 추가
                                            .font(.system(size: 30))
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .offset(y: 20)
                        .onChange(of: viewModel.pickerItem) {
                            Task {
                                if let data = try? await viewModel.pickerItem?.loadTransferable(type: Data.self),
                                   let image = UIImage(data: data) {
                                    await viewModel.updateSelectedImage(image)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ProfileSelectedView()
}
