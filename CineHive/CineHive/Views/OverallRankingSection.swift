//
//  OverallRankingSection.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct OverallRankingSection: View {
    let viewModel: MovieViewModel
    
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title with highlighting badge
            HStack {
                Text("종합 랭킹")
                    .font(.title3)
                    .bold()
                    .foregroundColor(textColor)
                
                Text("HOT")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(accentColor)
                    .cornerRadius(4)
                
                Spacer()
                
                Button {
                    // 더 많은 랭킹 보기
                } label: {
                    Text("더보기")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .buttonStyle(ScaleButtonStyle())
            }
            .padding(.horizontal, 15)
            
            // Content
            TabView {
                // Top 10 Movies
                OverallRankingListView(title: "전체 TOP 10", viewModel: viewModel)
                
                // Top 10 New Releases
                OverallRankingListView(title: "신규 콘텐츠 TOP 10", viewModel: viewModel)
                
                // Top 10 This Week
                OverallRankingListView(title: "이번주 인기 TOP 10", viewModel: viewModel)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .frame(height: 420)
        }
        .padding(.top, 30)
    }
}

struct OverallRankingListView: View {
    let title: String
    let viewModel: MovieViewModel
    
    private let textColor = Color.white
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // List Title
            Text(title)
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 15)
                .padding(.bottom, 5)
            
            // Ranking List
            ForEach(1...10, id: \.self) { rank in
                NavigationLink(destination: DetailView(movieId: rank * 100)) {
                    OverallRankingItemView(rank: rank)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 10)
    }
}

struct OverallRankingItemView: View {
    let rank: Int
    
    private let textColor = Color.white
    private let rankColors: [Color] = [.yellow, .gray.opacity(0.8), .brown.opacity(0.7)]
    
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
    
    // 영화 제목 데이터 (실제로는 API에서 가져와야 함)
    private var movieTitle: String {
        let titles = [
            "인셉션", "어벤져스: 엔드게임", "인터스텔라",
            "스파이더맨: 노 웨이 홈", "조커", "듄",
            "007 노 타임 투 다이", "샹치", "블랙 위도우", "이터널스"
        ]
        return titles.count > rank - 1 ? titles[rank - 1] : "영화 \(rank)"
    }
    
    // 어느 OTT 서비스에서 제공되는지 (실제로는 API에서 가져와야 함)
    private var ottServices: [OTTService] {
        let all = OTTService.allCases
        // 랭크에 따라 다양한 OTT 조합 생성
        switch rank % 4 {
        case 0: return [.netflix, .disney, .wavve]
        case 1: return [.disney, .apple]
        case 2: return [.netflix]
        default: return [.wavve, .tving]
        }
    }
    
    var body: some View {
        HStack(spacing: 15) {
            // Rank
            Text("\(rank)")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(rank <= 3 ? rankColors[rank-1] : textColor.opacity(0.7))
                .frame(width: 30)
            
            // Poster
            PosterView(
                posterURL: URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath).jpg"),
                width: 60,
                height: 90
            )
            .cornerRadius(4)
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(movieTitle)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(textColor)
                    .lineLimit(1)
                
                // Genre & Year
                Text("액션 • 드라마 • 2023")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 10))
                    
                    Text(String(format: "%.1f", 8.0 + Double(rank % 20) / 10))
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                // OTT services
                HStack(spacing: 5) {
                    ForEach(ottServices, id: \.self) { ott in
                        Image(systemName: ott.iconName)
                            .foregroundColor(ott.color)
                            .font(.system(size: 12))
                    }
                }
            }
            
            Spacer()
            
            // Trend indicator
            VStack {
                if rank % 3 == 0 {
                    Image(systemName: "arrow.up")
                        .foregroundColor(.green)
                        .font(.system(size: 12))
                    
                    Text("+2")
                        .font(.system(size: 12))
                        .foregroundColor(.green)
                } else if rank % 3 == 1 {
                    Image(systemName: "arrow.down")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                    
                    Text("-1")
                        .font(.system(size: 12))
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "minus")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    
                    Text("0")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 30)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 15)
        .background(Color.clear)
        .contentShape(Rectangle())
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        OverallRankingSection(viewModel: MovieViewModel())
    }
}
