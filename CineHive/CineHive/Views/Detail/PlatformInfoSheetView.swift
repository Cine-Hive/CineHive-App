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
    
    init(movie: MovieDetail, onDismiss: @escaping () -> Void) {
        self.movie = movie
        self.onDismiss = onDismiss
        self.platforms = StreamingPlatform.getPlatformsForMovie(id: movie.id)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 헤더
            HStack {
                Text("\(movie.title)")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title3)
                }
            }
            
            // 구분선
            Divider()
            
            // 스트리밍 플랫폼 정보
            if platforms.isEmpty {
                EmptyPlatformsView()
            } else {
                AvailablePlatformsView(platforms: platforms)
            }
            
            // 영화 가격 정보
            RentalPurchaseInfoView()
            
            Spacer()
            
            // 정보 출처 및 면책 조항
            Text("가격 정보는 변경될 수 있습니다. 구매 전 해당 서비스에서 최신 정보를 확인하세요.")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.top, 16)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

// MARK: - 서브 컴포넌트

struct EmptyPlatformsView: View {
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle")
                .foregroundColor(.red)
            Text("현재 스트리밍 서비스에서 제공되지 않습니다.")
                .font(.subheadline)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct AvailablePlatformsView: View {
    let platforms: [StreamingPlatform]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("다음 플랫폼에서 시청 가능:")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 10)
            
            ForEach(platforms) { platform in
                HStack(spacing: 12) {
                    Image(systemName: platform.logo)
                        .foregroundColor(platform.color)
                        .font(.title3)
                    
                    Text(platform.name)
                        .font(.body)
                    
                    Spacer()
                    
                    Text(platform.price)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(4)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(8)
            }
        }
    }
}

struct RentalPurchaseInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("대여 및 구매 정보")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 16)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("대여")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("48시간 이용 가능")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("₩3,900")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("구매")
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    Text("영구 소장")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text("₩12,900")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(8)
        }
    }
}

#Preview {
    // 더미 영화 데이터 생성
    let dummyMovie = MovieDetail.dummy
    
    return PlatformInfoSheetView(movie: dummyMovie, onDismiss: {})
}
