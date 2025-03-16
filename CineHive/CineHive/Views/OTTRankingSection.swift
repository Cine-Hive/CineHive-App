//
//  OTTRankingSection.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct OTTRankingSection: View {
    let viewModel: MovieViewModel
    @State private var selectedOTT: OTTService = .netflix
    
    private let backgroundColor = Color.black
    private let textColor = Color.white
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title with OTT selector
            HStack {
                Text("OTT 랭킹")
                    .font(.title3)
                    .bold()
                    .foregroundColor(textColor)
                
                Spacer()
                
                OTTSelector(selectedOTT: $selectedOTT)
            }
            .padding(.horizontal, 15)
            
            // Content
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 12) {
                    ForEach(1...10, id: \.self) { index in
                        NavigationLink(destination: DetailView(movieId: index * 100)) {
                            OTTRankingItemView(rank: index, ottService: selectedOTT)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .padding(.bottom, 10)
            }
        }
        .padding(.top, 30)
    }
}

struct OTTSelector: View {
    @Binding var selectedOTT: OTTService
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(OTTService.allCases, id: \.self) { ott in
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        selectedOTT = ott
                    }
                } label: {
                    Image(systemName: ott.iconName)
                        .font(.system(size: 18))
                        .foregroundColor(selectedOTT == ott ? ott.color : .gray)
                        .frame(width: 36, height: 36)
                        .background(
                            Circle()
                                .fill(selectedOTT == ott ? ott.color.opacity(0.2) : Color.gray.opacity(0.1))
                        )
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }
}

struct OTTRankingItemView: View {
    let rank: Int
    let ottService: OTTService
    
    private let textColor = Color.white
    
    // Random poster image from a set of paths
    private var posterPath: String {
        let paths = [
            "9Gtg2DzBhmYamXBS1hKAhiwbBKS",
            "t6HIqrRAclMzcQm5ynoNekJtgxY",
            "7WsyChQLEftFiDOVTGkv3hFpyyt",
            "vZloFAK7NmvMCKE7XmjxvC5wekX",
            "qNBAXBIQlnOThrVvA6mA2B5ggV6"
        ]
        return paths[rank % paths.count]
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // Poster with rank badge
            ZStack(alignment: .topLeading) {
                // Poster
                PosterView(
                    posterURL: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath).jpg"),
                    width: 120,
                    height: 180
                )
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 0.5)
                )
                
                // Rank badge
                ZStack {
                    Circle()
                        .fill(ottService.color)
                        .frame(width: 28, height: 28)
                    
                    Text("\(rank)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
                .shadow(color: .black.opacity(0.5), radius: 3)
                .offset(x: -5, y: -5)
            }
            
            // OTT logo and title
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: ottService.iconName)
                        .foregroundColor(ottService.color)
                        .font(.system(size: 12))
                    
                    Text(ottService.name)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
                
                Text("콘텐츠 \(rank)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(textColor)
                    .lineLimit(1)
                
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 11))
                    
                    Text(String(format: "%.1f", 8.0 + Double(rank % 20) / 10))
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 120, alignment: .leading)
        }
    }
}

enum OTTService: String, CaseIterable {
    case netflix
    case disney
    case apple
    case wavve
    case tving
    
    var name: String {
        switch self {
        case .netflix: return "넷플릭스"
        case .disney: return "디즈니+"
        case .apple: return "애플TV+"
        case .wavve: return "웨이브"
        case .tving: return "티빙"
        }
    }
    
    var iconName: String {
        switch self {
        case .netflix: return "n.square.fill"
        case .disney: return "d.square.fill"
        case .apple: return "apple.logo"
        case .wavve: return "w.square.fill"
        case .tving: return "t.square.fill"
        }
    }
    
    var color: Color {
        switch self {
        case .netflix: return .red
        case .disney: return .blue
        case .apple: return .gray
        case .wavve: return .cyan
        case .tving: return .red.opacity(0.8)
        }
    }
}
