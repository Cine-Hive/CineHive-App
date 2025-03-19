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
    
    private let genres = ["영화", "드라마", "애니메이션"]
    @State private var selectedGenres: Set<String> = []
    
    private let services = ["Netflix", "Disney+", "TVING", "Apple TV+", "Wavve", "Watcha", "coupang \nplay", "kakao TV"]
    @State private var selectedServices: Set<String> = []
    
    private let countries: [String] = ["대한민국", "미국", "일본", "중국", "영국", "프랑스", "이탈리아", "스페인", "호주", "독일"]
    @State private var selectedCountry: String = "대한민국"
    
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 3)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            VStack {
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
                    Spacer()
                }
                Spacer()
                VStack {
                    Text("장르 선택")
                        .frame(width: 330, height: 30, alignment: .leading)
                        .font(.system(size: 18, weight: .semibold))
                    Text("선호하는 장르를 선택해보세요")
                        .frame(width: 330, height: 20, alignment: .leading)
                        .font(.system(size: 14, weight: .light))
                    LazyVGrid(columns: columns) {
                        ForEach(genres, id: \.self) { genres in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectedGenres.contains(genres) ? Color("LoginBtnColor") : Color.gray, lineWidth: 1)
                                    .background(
                                        selectedGenres.contains(genres) ? Color("LoginBtnColor").opacity(0.1) : Color.white
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: 105, height: 95)
                                Text(genres)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(selectedGenres.contains(genres) ? Color("LoginBtnColor") : Color.gray)
                            }
                            
                            .onTapGesture {
                                if selectedGenres.contains(genres) {
                                    selectedGenres.remove(genres)
                                } else {
                                    selectedGenres.insert(genres)
                                }
                            }
                            
                            
                        }
                    }
                    
                }
                .frame(width: 350, height: 180)
                // 구독 중인 서비스 선택
                VStack {
                    Spacer()
                    Text("구독 중인 서비스")
                        .frame(width: 330, height: 30, alignment: .leading)
                        .font(.system(size: 18, weight: .semibold))
                    Text("구독 중인 서비스를 선택해보세요")
                        .frame(width: 330, height: 20, alignment: .leading)
                        .font(.system(size: 14, weight: .light))
                    
                    LazyVGrid(columns: columns) {
                        ForEach(services, id: \.self) { services in
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectedServices.contains(services) ? Color("LoginBtnColor") : Color.gray, lineWidth: 1)
                                    .background(
                                        selectedServices.contains(services) ? Color("LoginBtnColor").opacity(0.1) : Color.white
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .frame(width: 105, height: 95)
                                Text(services)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(selectedServices.contains(services) ? Color("LoginBtnColor") : Color.gray)
                            }
                            
                            .onTapGesture {
                                if selectedServices.contains(services) {
                                    selectedServices.remove(services)
                                } else {
                                    selectedServices.insert(services)
                                }
                            }
                            
                            
                        }
                    }
                }
                .frame(width: 350, height: 380)
                
                
                VStack {
                    Text("서비스 지역")
                        .frame(width: 330, height: 30, alignment: .leading)
                        .font(.system(size: 18, weight: .semibold))
                    Text("현지 추천을 위해 선택해보세요")
                        .frame(width: 330, height: 20, alignment: .leading)
                        .font(.system(size: 14, weight: .light))
                    Menu(selectedCountry) {
                        ForEach(countries, id: \.self) { region in
                            Button(action: {
                                selectedCountry = region
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
                
                Button(action: {
                }, label: {
                    Text("건너 뛰기")
                        .frame(width: 330, height: 50)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("LoginBtnColor"))
                        .background(Color(UIColor.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("LoginBtnColor"), lineWidth: 1)
                        )
                })
                
                Button(action: {
                }, label: {
                    Text("선택 완료")
                        .frame(width: 330, height: 50)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color("LoginBtnColor"))
                        .background(Color(UIColor.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color("LoginBtnColor"), lineWidth: 1)
                        )
                })

            }
        })
        .frame(width: .infinity, height: .infinity)
    }
}

#Preview {
    AdditionalInfoView()
}
