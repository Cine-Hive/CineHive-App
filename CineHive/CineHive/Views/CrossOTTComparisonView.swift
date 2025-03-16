//
//  CrossOTTComparisonView.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct CrossOTTComparisonView: View {
    let movie: Movie
    
    private let textColor = Color.white
    private let backgroundColor = Color.black
    
    // Sample OTT availability
    private let availableOTTs: [OTTInfo] = [
        OTTInfo(service: .netflix, price: "기본 구독", quality: "4K HDR"),
        OTTInfo(service: .disney, price: "구독 필요", quality: "4K Dolby Vision"),
        OTTInfo(service: .wavve, price: "₩3,500", quality: "FHD")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            Text("시청 가능한 OTT 서비스")
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.top, 10)
            
            // OTT comparison table
            VStack(spacing: 1) {
                // Header
                HStack {
                    Text("플랫폼")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 120, alignment: .leading)
                    
                    Text("가격")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("화질")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(width: 80, alignment: .trailing)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.gray.opacity(0.2))
                
                // OTT rows
                ForEach(availableOTTs) { ott in
                    ottServiceRow(ott)
                    
                    if ott != availableOTTs.last {
                        Divider()
                            .background(Color.gray.opacity(0.3))
                    }
                }
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            
            // Not available notice
            Text("정보가 부정확할 수 있으니 해당 서비스에서 제공하는 정보를 확인해주세요.")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 6)
        }
        .padding(.horizontal, 16)
    }
    
    private func ottServiceRow(_ ott: OTTInfo) -> some View {
        Button {
            // Open OTT app or link
        } label: {
            HStack {
                // Platform
                HStack(spacing: 8) {
                    Image(systemName: ott.service.iconName)
                        .foregroundColor(ott.service.color)
                        .font(.system(size: 16))
                    
                    Text(ott.service.name)
                        .font(.subheadline)
                        .foregroundColor(textColor)
                }
                .frame(width: 120, alignment: .leading)
                
                // Price
                Text(ott.price)
                    .font(.subheadline)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Quality
                Text(ott.quality)
                    .font(.subheadline)
                    .foregroundColor(textColor)
                    .frame(width: 80, alignment: .trailing)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct OTTInfo: Identifiable, Equatable {
    let id = UUID()
    let service: OTTService
    let price: String
    let quality: String
    
    static func == (lhs: OTTInfo, rhs: OTTInfo) -> Bool {
        lhs.id == rhs.id
    }
}

struct OTTInfoCard: View {
    let service: OTTService
    let showReleaseDate: Bool
    
    @State private var isExpanded = false
    
    private let textColor = Color.white
    private let backgroundColor = Color.black
    
    // Sample data - in a real app, this would come from a model
    var releaseDate: String {
        let dates = [
            "2023년 10월 15일",
            "2023년 11월 3일",
            "2023년 9월 28일",
            "2023년 12월 1일",
            "2023년 10월 30일"
        ]
        return dates[Int(service.hashValue) % dates.count]
    }
    
    var features: [String] {
        switch service {
        case .netflix:
            return ["4K UHD 지원", "다운로드 가능", "더빙/자막 지원"]
        case .disney:
            return ["IMAX Enhanced", "Dolby Vision", "다운로드 가능"]
        case .apple:
            return ["4K Dolby Vision", "가족 공유 가능", "무광고"]
        case .wavve:
            return ["1080p FHD", "한국어 자막", "국내 독점 콘텐츠"]
        case .tving:
            return ["최대 1080p", "다운로드 가능", "무광고 요금제 있음"]
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            Button(action: {
                withAnimation(.spring()) {
                    isExpanded.toggle()
                }
                
                let impactFeedback = UIImpactFeedbackGenerator(style: .light)
                impactFeedback.impactOccurred()
            }) {
                HStack {
                    // OTT Logo
                    Image(systemName: service.iconName)
                        .font(.system(size: 20))
                        .foregroundColor(service.color)
                        .frame(width: 32, height: 32)
                        .background(service.color.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    // Service name
                    Text(service.name)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(textColor)
                    
                    Spacer()
                    
                    // Expand icon
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            
            // Expanded content
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    if showReleaseDate {
                        HStack {
                            Text("공개일:")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            Text(releaseDate)
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                    }
                    
                    // Features
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(features, id: \.self) { feature in
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(service.color)
                                
                                Text(feature)
                                    .font(.system(size: 14))
                                    .foregroundColor(.white.opacity(0.9))
                            }
                        }
                    }
                    
                    // CTA Button
                    Button {
                        // Open OTT app
                    } label: {
                        HStack {
                            Text("자세히 보기")
                                .font(.system(size: 14, weight: .medium))
                            
                            Image(systemName: "arrow.up.right.square")
                                .font(.system(size: 12))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 8)
                        .background(service.color)
                        .cornerRadius(4)
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 14)
                .padding(.bottom, 14)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .background(Color.gray.opacity(0.15))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct OTTInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                OTTInfoCard(service: .netflix, showReleaseDate: true)
                OTTInfoCard(service: .disney, showReleaseDate: false)
                OTTInfoCard(service: .apple, showReleaseDate: true)
            }
            .padding()
        }
    }
}
