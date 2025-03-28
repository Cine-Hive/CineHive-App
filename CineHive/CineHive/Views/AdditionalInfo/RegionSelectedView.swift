//
//  RegionSelectedView.swift
//  CineHive
//
//  Created by 존진 on 3/27/25.
//

import SwiftUI

struct RegionSelectedView: View {
    @Bindable var viewModel = AdditionalInfoViewModel()
    
    var body: some View {
        VStack {
            InfoStepContainer(
                title: "관심 있는 국가를 선택하세요!",
                subtitle: "선택한 국가를 기반으로 콘텐츠를 추천해드릴게요") {
                    Menu(viewModel.selectedCountry ?? "클릭하여 국가 선택") {
                        ForEach(viewModel.countries, id: \.self) { region in
                            Button(action: {
                                viewModel.selectedCountry = region
                            }, label: {
                                Text(region)
                                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white))
                            })
                        }
                    }
                    .frame(width: 330, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white, lineWidth: 1)
                    )
                    .tint(Color.white)
                }
        }
    }
}
