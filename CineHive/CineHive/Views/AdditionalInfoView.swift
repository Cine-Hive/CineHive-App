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
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
                Text("프로필을 완성해보세요!")
                    .frame(width: 330, height: 70, alignment: .leading)
                    .font(.system(size: 23, weight: .semibold))
                Spacer()
                // 프로필 이미지 추가
                ProfileSelectedView(viewModel: viewModel)
                Spacer()
                // 장르 선택
                GenreSelectedView(viewModel: viewModel)
                // 구독 중인 서비스 선택
                ServiceSelectedView(viewModel: viewModel)
                // 서비스 지역 선택
                RegionSelectedView(viewModel: viewModel)
                
                HStack {
                    Spacer()
                    Button(action: {
                        isShowingView = true
                    }, label: {
                        Text("건너 뛰기")
                            .frame(width: 140, height: 50)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.gray)
                            .background(Color(UIColor.systemBackground))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                    })
                    .fullScreenCover(isPresented: $isShowingView) {
                        MainTabView()
                    }
                    Button(action: {
                        isShowingView = true
                    }, label: {
<<<<<<< HEAD
                        Text("다음으로")
                            .frame(width: 180, height: 50)
                            .font(.system(size: 17, weight: .semibold))
                            .background(viewModel.isSelectionValid() ? CHColors.Button.primary : Color.gray)
=======
                        Text("선택 완료")
                            .frame(width: 180, height: 50)
                            .font(.system(size: 17, weight: .semibold))
                            .background(viewModel.isSelectionValid() ? Color("LoginBtnColor") : Color.gray)
>>>>>>> origin/feature/additional-info-ui
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
        })
    }
}

#Preview {
    AdditionalInfoView()
}

struct ProfileSelectedView: View {
    @Bindable var viewModel: AdditionalInfoViewModel
    
    var body: some View {
        VStack {
            Spacer()
            PhotosPicker(selection: $viewModel.pickerItem, matching: .images) {
                ZStack {
                    if let image = viewModel.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
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
                .onChange(of: viewModel.pickerItem) {
                    Task {
                        if let data = try? await viewModel.pickerItem?.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            await viewModel.updateSelectedImage(image)
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

struct GenreSelectedView: View {
    @Bindable var viewModel: AdditionalInfoViewModel
    
    var body: some View {
        VStack {
            Text("장르 선택")
                .frame(width: 330, height: 30, alignment: .leading)
                .font(.system(size: 18, weight: .semibold))
            Text("선호하는 장르를 선택해보세요")
                .frame(width: 330, height: 20, alignment: .leading)
                .font(.system(size: 14, weight: .light))
            LazyVGrid(columns: viewModel.columns) {
                ForEach(viewModel.genres, id: \.self) { genres in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(viewModel.selectedGenres.contains(genres) ? CHColors.Button.primary : Color.gray, lineWidth: 1)
                            .background(
                                viewModel.selectedGenres.contains(genres) ? CHColors.Button.primary.opacity(0.1) : Color.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 105, height: 95)
                        Text(genres)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(viewModel.selectedGenres.contains(genres) ? CHColors.Button.primary : Color.gray)
                    }
                    
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
        .frame(width: 350, height: 180)
    }
}

struct ServiceSelectedView: View {
    @Bindable var viewModel: AdditionalInfoViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text("구독 중인 서비스")
                .frame(width: 330, height: 30, alignment: .leading)
                .font(.system(size: 18, weight: .semibold))
            Text("구독 중인 서비스를 선택해보세요")
                .frame(width: 330, height: 20, alignment: .leading)
                .font(.system(size: 14, weight: .light))
            
            LazyVGrid(columns: viewModel.columns) {
                ForEach(viewModel.services, id: \.self) { services in
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(viewModel.selectedServices.contains(services) ? CHColors.Button.primary : Color.gray, lineWidth: 1)
                            .background(
                                viewModel.selectedServices.contains(services) ? CHColors.Button.primary.opacity(0.1) : Color.white
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 105, height: 95)
<<<<<<< HEAD
                        VStack(spacing: 5) {
                            Image(systemName: viewModel.serviceIcons[services] ?? "questionmark")
                                .font(.system(size: 20))
                                .foregroundColor(viewModel.selectedServices.contains(services) ? CHColors.Button.primary : Color.gray)
                            Text(services)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(viewModel.selectedServices.contains(services) ? CHColors.Button.primary : Color.gray)
                        }
                        .padding()
                        
=======
                        Text(services)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(viewModel.selectedServices.contains(services) ? Color("LoginBtnColor") : Color.gray)
>>>>>>> origin/feature/additional-info-ui
                    }
                    .onTapGesture {
                        if viewModel.selectedServices.contains(services) {
                            viewModel.selectedServices.remove(services)
                        } else {
                            viewModel.selectedServices.insert(services)
                        }
                    }
                }
            }
        }
        .frame(width: 350, height: 380)
    }
}

struct RegionSelectedView: View {
    @Bindable var viewModel: AdditionalInfoViewModel
    
    var body: some View {
        VStack {
            Text("서비스 지역")
                .frame(width: 330, height: 30, alignment: .leading)
                .font(.system(size: 18, weight: .semibold))
            Text("현지 추천을 위해 선택해보세요")
                .frame(width: 330, height: 20, alignment: .leading)
                .font(.system(size: 14, weight: .light))
            Menu(viewModel.selectedCountry ?? "클릭하여 지역 선택") {
                ForEach(viewModel.countries, id: \.self) { region in
                    Button(action: {
                        viewModel.selectedCountry = region
                    }, label: {
                        Text(region)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.black))
                    })
                }
            }
            .frame(width: 330, height: 50)
            .background(Color(UIColor.systemBackground))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .tint(Color.black)
        }
        .frame(width: 350, height: 180)
    }
}
