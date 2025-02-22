//
//  DetailView.swift
//  CineHive
//
//  Created by 이종민 on 2/22/25.
//

import SwiftUI

struct DetailView: View {
    let movie: Movie
    @State private var isExpanded: Bool = false

    var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: - Header: 포스터와 기본 정보
                    HStack(alignment: .top, spacing: 16) {
                        if let posterURL = movie.posterURL {
                            AsyncImage(url: posterURL) { phase in
                                switch phase {
                                case .empty:
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 120, height: 180)
                                        .cornerRadius(10)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 120, height: 180)
                                        .clipped()
                                        .cornerRadius(10)
                                        .shadow(radius: 4)
                                case .failure:
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 120, height: 180)
                                        .foregroundColor(.gray)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(movie.title)
                                .font(.title)
                                .bold()
                            
                            Text("감독: \(movie.director.name)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            Text("개봉일: \(movie.releaseDate)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 8)
                        
                        Spacer()
                    }
                    
                    Divider()
                    
                    // MARK: - 줄거리 (더보기 기능 추가)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("줄거리")
                            .font(.headline)

                        Text(movie.overview)
                            .font(.body)
                            .lineSpacing(4)
                            .lineLimit(isExpanded ? nil : 2) // 2줄까지만 표시 (더보기 전)
                            .animation(.easeInOut, value: isExpanded) // 애니메이션 추가

                        Button(action: {
                            isExpanded.toggle() // 버튼 클릭 시 상태 변경
                        }) {
                            Text(isExpanded ? "접기 ▲" : "더보기 ▼") // 버튼 텍스트 변경
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }

                    // MARK: - 출연 배우 (배열이 비어있지 않은 경우)
                    if !movie.actors.isEmpty {
                        Divider()
                        
                        Text("출연 배우")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(movie.actors, id: \.id) { actor in
                                    VStack(spacing: 8) {
                                        // 배우 이미지 자리 (실제 이미지가 있다면 AsyncImage 사용 가능)
                                        Circle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 60, height: 60)
                                        
                                        Text(actor.name)
                                            .font(.caption)
                                            .multilineTextAlignment(.center)
                                            .frame(width: 70)
                                    }
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("영화 상세 정보")
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    DetailView(movie: Movie.dummyMovie)
}
