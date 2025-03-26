//
//  SearchView.swift
//  CineHive
//
//  Created by 이종민 on 3/22/25.
//

import SwiftUI

// 검색 오버레이 컴포넌트
struct SearchView: View {
    @Binding var searchText: String
    @Binding var isSearchActive: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            // 검색 헤더
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(CHColors.secondaryColor)
                
                TextField("영화, TV 프로그램, 인물 검색", text: $searchText)
                    .foregroundColor(CHColors.textColor)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(CHColors.secondaryColor)
                    }
                }
                
                Button {
                    withAnimation(.spring(response: 0.3)) {
                        isSearchActive = false
                        searchText = ""
                    }
                } label: {
                    Text("취소")
                        .foregroundColor(CHColors.primaryColor)
                }
            }
            .padding()
            .background(Color(hex: "#1A1A1A"))
            
            // 검색 결과 또는 추천 검색어
            ScrollView {
                if searchText.isEmpty {
                    // 인기 검색어
                    VStack(alignment: .leading, spacing: 15) {
                        Text("인기 검색어")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        ForEach(1...10, id: \.self) { index in
                            HStack {
                                Text("\(index)")
                                    .font(.system(size: 14))
                                    .foregroundColor(index <= 3 ? CHColors.primaryColor : CHColors.secondaryColor)
                                    .frame(width: 20)
                                
                                Text("인기 검색어 \(index)")
                                    .font(.system(size: 16))
                                    .foregroundColor(CHColors.textColor)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 8)
                        }
                    }
                } else {
                    // 검색 결과
                    Text("'\(searchText)'에 대한 검색 결과")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    if searchText.count > 1 {
                        ForEach(1...5, id: \.self) { _ in
                            SearchResultRow()
                        }
                    } else {
                        Text("검색어를 더 입력해주세요")
                            .foregroundColor(CHColors.secondaryColor)
                            .padding()
                    }
                }
            }
            .background(CHColors.backgroundColor)
        }
        .background(CHColors.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

// 검색 결과 행 컴포넌트
struct SearchResultRow: View {
    var body: some View {
        HStack(spacing: 15) {
            // 포스터
            RoundedRectangle(cornerRadius: 4)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 45, height: 68)
            
            // 정보
            VStack(alignment: .leading, spacing: 4) {
                Text("검색 결과 제목")
                    .font(.system(size: 16))
                    .foregroundColor(CHColors.textColor)
                
                HStack {
                    Text("2023")
                    Text("•")
                    Text("영화")
                    Text("•")
                    Text("액션")
                }
                .font(.caption)
                .foregroundColor(CHColors.secondaryColor)
                
                // OTT 플랫폼
                HStack {
                    Image(systemName: "n.square.fill")
                        .foregroundColor(CHColors.OTT.netflix)
                    
                    Image(systemName: "d.square.fill")
                        .foregroundColor(CHColors.OTT.disney)
                    
                    Spacer()
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(CHColors.starColor)
                        .font(.system(size: 10))
                    
                    Text("8.7")
                        .font(.system(size: 12))
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
    }
}
