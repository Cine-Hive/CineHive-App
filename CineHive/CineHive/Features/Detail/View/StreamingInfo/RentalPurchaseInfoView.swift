//
//  RentalPurchaseInfoView.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct RentalPurchaseInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "cart.fill")
                    .foregroundColor(PlatformInfoSheetTheme.accent)
                    .font(.system(size: 16))
                
                Text("대여 및 구매 정보")
                    .font(.headline)
                    .foregroundColor(PlatformInfoSheetTheme.text)
            }
            .padding(.top, 6)
            
            VStack(spacing: 12) {
                // 대여 옵션
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("대여")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(PlatformInfoSheetTheme.text)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 10))
                                .foregroundColor(PlatformInfoSheetTheme.secondaryText)
                            
                            Text("48시간 이용 가능")
                                .font(.caption)
                                .foregroundColor(PlatformInfoSheetTheme.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    Text("₩3,900")
                        .font(.headline)
                        .foregroundColor(PlatformInfoSheetTheme.priceColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(PlatformInfoSheetTheme.cardBackground)
                .cornerRadius(10)
                
                // 구매 옵션
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("구매")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(PlatformInfoSheetTheme.text)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "infinity")
                                .font(.system(size: 10))
                                .foregroundColor(PlatformInfoSheetTheme.secondaryText)
                            
                            Text("영구 소장")
                                .font(.caption)
                                .foregroundColor(PlatformInfoSheetTheme.secondaryText)
                        }
                    }
                    
                    Spacer()
                    
                    Text("₩12,900")
                        .font(.headline)
                        .foregroundColor(PlatformInfoSheetTheme.priceColor)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 14)
                .background(PlatformInfoSheetTheme.cardBackground)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    RentalPurchaseInfoView()
}
