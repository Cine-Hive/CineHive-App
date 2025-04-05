//
//  AvailablePlatformsView.swift
//  CineHive
//
//  Created by 이종민 on 3/10/25.
//

import SwiftUI

struct AvailablePlatformsView: View {
    let platforms: [StreamingPlatform]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "play.tv.fill")
                    .foregroundColor(PlatformInfoSheetTheme.accent)
                    .font(.system(size: 16))
                
                Text("다음 플랫폼에서 시청 가능")
                    .font(.headline)
                    .foregroundColor(PlatformInfoSheetTheme.text)
            }
            
            ForEach(platforms) { platform in
                HStack(spacing: 14) {
                    Image(systemName: platform.logo)
                        .foregroundColor(platform.color)
                        .font(.title3)
                        .frame(width: 24)
                    
                    Text(platform.name)
                        .font(.body)
                        .foregroundColor(PlatformInfoSheetTheme.text)
                    
                    Spacer()
                    
                    Text(platform.price)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(PlatformInfoSheetTheme.text)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(PlatformInfoSheetTheme.priceBackground)
                        .cornerRadius(8)
                }
                .padding(.vertical, 14)
                .padding(.horizontal, 16)
                .background(PlatformInfoSheetTheme.cardBackground)
                .cornerRadius(10)
            }
        }
    }
}
