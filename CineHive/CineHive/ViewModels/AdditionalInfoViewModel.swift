//
//  AdditionalInfoViewModel.swift
//  CineHive
//
//  Created by 존진 on 3/11/25.
//

import Foundation
import SwiftUI
import PhotosUI

@Observable
class AdditionalInfoViewModel {
    var selectedImage: UIImage? = nil
    var pickerItem: PhotosPickerItem?
    
    // 장르 및 서비스 선택 상태
    var selectedGenres: Set<String> = []
    var selectedServices: Set<String> = []
    var selectedCountry: String = "대한민국"
    
    // 선택 가능한 데이터 (상수)
    let genres = ["영화", "드라마", "애니메이션"]
    let services = ["Netflix", "Disney+", "TVING", "Apple TV+", "Wavve", "Watcha", "coupang\nplay", "kakao TV", "prime\nvideo"]
    let countries: [String] = ["대한민국", "미국", "일본", "중국", "영국", "프랑스", "이탈리아", "스페인", "호주", "독일"]
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 3)
    
    @MainActor
    func updateSelectedImage(_ image: UIImage?) {
        self.selectedImage = image
    }
}
