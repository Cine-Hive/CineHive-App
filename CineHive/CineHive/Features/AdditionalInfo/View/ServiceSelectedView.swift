//
//  ServiceSelectedView.swift
//  CineHive
//
//  Created by 존진 on 3/27/25.
//

import SwiftUI

struct ServiceSelectedView: View {
    @Bindable var viewModel = AdditionalInfoViewModel()
    
    var body: some View {
        ZStack {
            CHColors.backgroundColor.edgesIgnoringSafeArea(.all)
            VStack {
                InfoStepContainer(
                    title: "어떤 서비스를 구독 중이신가요?",
                    subtitle: "구독 중인 서비스를 선택해보세요") {
                        LazyVGrid(columns: viewModel.columns) {
                            ForEach(viewModel.services, id: \.self) { services in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(viewModel.selectedServices.contains(services) ? CHColors.Button.primary : Color.gray, lineWidth: 1)
                                        .background(
                                            viewModel.selectedServices.contains(services) ? CHColors.Button.primary.opacity(0.1) : Color.background
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 15))
                                        .frame(width: 105, height: 95)
                                    VStack(spacing: 7) {
                                        Image(systemName: viewModel.serviceIcons[services] ?? "questionmark")
                                            .font(.system(size: 20))
                                            .foregroundColor(viewModel.selectedServices.contains(services) ? CHColors.Button.primary : Color.white)
                                        Text(services)
                                            .font(.system(size: 15, weight: .medium))
                                            .foregroundColor(viewModel.selectedServices.contains(services) ? CHColors.Button.primary : Color.white)
                                    }
                                    .padding()
                                    
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
            }
        }
    }
}

#Preview {
    ServiceSelectedView()
}
