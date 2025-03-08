//
//  PlatformInfoSheetView.swift
//  CineHive
//
//  Created by 이종민 on 3/7/25.
//

import SwiftUI

struct PlatformInfoSheetView: View {
    let movie: MovieDetail
    let onDismiss: () -> Void
    private let platforms: [StreamingPlatform]
    
    // 테마 색상
    private struct Theme {
        static let background = Color.black
        static let text = Color.white
        static let secondaryText = Color.gray
        static let cardBackground = Color(white: 0.15)
        static let accent = Color.red
        static let divider = Color.gray.opacity(0.3)
    }
    
    init(movie: MovieDetail, onDismiss: @escaping () -> Void) {
        self.movie = movie
        self.onDismiss = onDismiss
        self.platforms = StreamingPlatform.getPlatformsForMovie(id: movie.id)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 22) {
            // 헤더
            HStack {
                Text(movie.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Theme.text)
                    .lineLimit(1)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Theme.secondaryText)
                        .font(.title2)
                }
            }
            
            // 구분선
            Rectangle()
                .fill(Theme.divider)
                .frame(height: 1)
                .padding(.vertical, 4)
            
            // 스트리밍 플랫폼 정보
            if platforms.isEmpty {
                EmptyPlatformsView()
            } else {
                AvailablePlatformsView(platforms: platforms)
            }
            
            // 영화 가격 정보
            RentalPurchaseInfoView()
            
            // 정보 출처 및 면책 조항
            HStack {
                Image(systemName: "info.circle")
                    .foregroundColor(Theme.accent)
                    .font(.system(size: 14))
                
                Text("가격 정보는 변경될 수 있습니다.\n구매 전 해당 서비스에서 최신 정보를 확인하세요.")
                    .font(.caption)
                    .foregroundColor(Theme.secondaryText)
            }
            .padding(.top, 8)
            .padding(.bottom, 12)
            
            Spacer()
        }
        .padding(20)
        .background(Theme.background)
        
    }
}

// MARK: - 서브 컴포넌트

struct EmptyPlatformsView: View {
    // 테마 색상
    private struct Theme {
        static let background = Color(white: 0.12)
        static let text = Color.white
        static let accent = Color.red
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "tv.slash")
                .font(.system(size: 40))
                .foregroundColor(Theme.accent)
            
            Text("현재 스트리밍 서비스에서 제공되지 않습니다")
                .font(.headline)
                .foregroundColor(Theme.text)
                .multilineTextAlignment(.center)
                
            Text("영화관에서 상영 중이거나 다른 플랫폼에서 출시 예정일 수 있습니다")
                .font(.caption)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .padding(.horizontal, 16)
        .background(Theme.background)
        .cornerRadius(12)
    }
}

struct AvailablePlatformsView: View {
    let platforms: [StreamingPlatform]
    
    // 테마 색상
    private struct Theme {
        static let text = Color.white
        static let secondaryText = Color.gray
        static let cardBackground = Color(white: 0.15)
        static let accent = Color.red
        static let priceBackground = Color.black.opacity(0.3)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "play.tv.fill")
                    .foregroundColor(Theme.accent)
                    .font(.system(size: 16))
                
                Text("다음 플랫폼에서 시청 가능")
                    .font(.headline)
                    .foregroundColor(Theme.text)
            }
            
            ForEach(platforms) { platform in
                HStack(spacing: 14) {
                    Image(systemName: platform.logo)
                        .foregroundColor(platform.color)
                        .font(.title3)
                        .frame(width: 24)
                    
                    Text(platform.name)
                        .font(.body)
                        .foregroundColor(Theme.text)
                    
                    Spacer()
                    
                    Text(platform.price)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(Theme.text)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Theme.priceBackground)
                        .cornerRadius(8)
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .background(Theme.cardBackground)
                .cornerRadius(10)
            }
        }
    }
}

struct RentalPurchaseInfoView: View {
    // 테마 색상
    private struct Theme {
        static let text = Color.white
        static let secondaryText = Color.gray
        static let cardBackground = Color(white: 0.15)
        static let accent = Color.red
        static let priceColor = Color.green
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "cart.fill")
                    .foregroundColor(Theme.accent)
                    .font(.system(size: 16))
                
                Text("대여 및 구매 정보")
                    .font(.headline)
                    .foregroundColor(Theme.text)
            }
            .padding(.top, 6)
            
            VStack(spacing: 12) {
                // 대여 옵션
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("대여")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(Theme.text)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 10))
                                .foregroundColor(Theme.secondaryText)
                            
                            Text("48시간 이용 가능")
                                .font(.caption)
                                .foregroundColor(Theme.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    Text("₩3,900")
                        .font(.headline)
                        .foregroundColor(Theme.priceColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Theme.cardBackground)
                .cornerRadius(10)
                
                // 구매 옵션
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("구매")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(Theme.text)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "infinity")
                                .font(.system(size: 10))
                                .foregroundColor(Theme.secondaryText)
                            
                            Text("영구 소장")
                                .font(.caption)
                                .foregroundColor(Theme.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    Text("₩12,900")
                        .font(.headline)
                        .foregroundColor(Theme.priceColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(Theme.cardBackground)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    // 더미 영화 데이터 생성
    let dummyMovie = MovieDetail.dummy
    
    return ZStack {
        PlatformInfoSheetView(movie: dummyMovie, onDismiss: {})
    }
}
