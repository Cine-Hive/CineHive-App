//
//  AdditionalInfoView.swift
//  CineHive
//
//  Created by 존진 on 3/10/25.
//

import SwiftUI
import PhotosUI

struct AdditionalInfoView: View {
    
    @State private var selectedImage: UIImage? = nil
    @State private var pickerItem: PhotosPickerItem?
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text("프로필을 완성해보세요!")
                    .frame(width: 330, height: 70, alignment: .leading)
                    .font(.system(size: 23, weight: .semibold))
                Spacer()
                // 프로필 이미지 추가
                VStack {
                    Spacer()
                    PhotosPicker(selection: $pickerItem, matching: .images) {
                        ZStack {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 128, height: 128)
                                    .clipShape(Circle()) // 원형 이미지
                                
                                
                            } else {
                                Circle()
                                    .stroke(Color.gray, lineWidth: 1) // 회색 테두리
                                    .frame(width: 128, height: 128)
                                    .overlay(
                                        Image(systemName: "camera") // SF Symbol 추가
                                            .font(.system(size: 30))
                                            .foregroundColor(.gray)
                                    )
                            }
                        }
                        .onChange(of: pickerItem) { _, _ in
                            Task {
                                if let data = try? await pickerItem?.loadTransferable(type: Data.self),
                                   let image = UIImage(data: data) {
                                    selectedImage = image
                                }
                            }
                        }
                    }
                    
                    Text("터치해서 프로필을 등록해보세요")
                        .frame(width: 330, height: 50, alignment: .center)
                        .font(.system(size: 14, weight: .light))
                    
                    
                }
            }
        }
    }
}

#Preview {
    AdditionalInfoView()
}
