//
//  DetailSkeletonView.swift
//  CineHive
//
//  Created by 이종민 on 3/26/25.
//

import SwiftUI

struct DetailSkeletonView: View {
    // 넷플릭스 스타일 색상 상수
    private let backgroundColor = Color.black
    private let textColor = Color.white
    private let accentColor = Color.red
    private let secondaryTextColor = Color.gray
    private let skeletonColor = Color.gray.opacity(0.3)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 헤더 섹션 (백드롭 이미지 + 포스터)
                headerSection
                
                Spacer().frame(height: 120)
                
                // 정보 바
                infoBarSection
                
                // 액션 버튼
                actionButtonsSection
                
                // 탭 선택기
                tabSelectSection
                
                // 탭 콘텐츠 (개요 탭)
                contentSection
            }
        }
        .background(backgroundColor)
        .redacted(reason: .placeholder)
    }
    
    // 헤더 섹션 (백드롭 + 포스터)
    private var headerSection: some View {
        ZStack(alignment: .bottomLeading) {
            // 백드롭 이미지
            Rectangle()
                .fill(skeletonColor)
                .frame(height: 250)
            
            HStack(alignment: .bottom) {
                // 포스터
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 120, height: 180)
                    .cornerRadius(8)
                    .offset(y: 30)
                
                VStack(alignment: .leading, spacing: 12) {
                    // 장르 태그
                    HStack(spacing: 8) {
                        ForEach(0..<3, id: \.self) { _ in
                            RoundedRectangle(cornerRadius: 4)
                                .fill(skeletonColor)
                                .frame(width: 60, height: 24)
                        }
                    }
                    
                    // 영화 제목
                    Rectangle()
                        .fill(skeletonColor)
                        .frame(width: 200, height: 30)
                        .cornerRadius(4)
                    
                    // 예고편 버튼
                    Rectangle()
                        .fill(skeletonColor)
                        .frame(width: 140, height: 40)
                        .cornerRadius(4)
                }
                .padding(.leading, 8)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, -50)
        }
    }
    
    // 정보 바 섹션
    private var infoBarSection: some View {
        HStack(spacing: 16) {
            Spacer()
            
            // 평점
            HStack(spacing: 4) {
                Circle()
                    .fill(skeletonColor)
                    .frame(width: 14, height: 14)
                
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 30, height: 14)
                    .cornerRadius(2)
            }
            
            Text("•").foregroundColor(secondaryTextColor)
            
            // 연도
            Rectangle()
                .fill(skeletonColor)
                .frame(width: 40, height: 14)
                .cornerRadius(2)
            
            Text("•").foregroundColor(secondaryTextColor)
            
            // 인기도
            Rectangle()
                .fill(skeletonColor)
                .frame(width: 60, height: 14)
                .cornerRadius(2)
            
            Text("•").foregroundColor(secondaryTextColor)
            
            // 런타임
            Rectangle()
                .fill(skeletonColor)
                .frame(width: 40, height: 14)
                .cornerRadius(2)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(backgroundColor)
    }
    
    // 액션 버튼 섹션
    private var actionButtonsSection: some View {
        HStack(spacing: 0) {
            // 관심목록 버튼
            VStack(spacing: 8) {
                Circle()
                    .fill(skeletonColor)
                    .frame(width: 24, height: 24)
                
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 60, height: 12)
                    .cornerRadius(2)
            }
            .frame(maxWidth: .infinity)
            
            // 시청 정보 버튼
            VStack(spacing: 8) {
                Circle()
                    .fill(skeletonColor)
                    .frame(width: 24, height: 24)
                
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 60, height: 12)
                    .cornerRadius(2)
            }
            .frame(maxWidth: .infinity)
            
            // 공유 버튼
            VStack(spacing: 8) {
                Circle()
                    .fill(skeletonColor)
                    .frame(width: 24, height: 24)
                
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 60, height: 12)
                    .cornerRadius(2)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 16)
        .background(backgroundColor)
    }
    
    // 탭 선택 섹션
    private var tabSelectSection: some View {
        HStack(spacing: 20) {
            Spacer()
            
            // 각 탭 항목
            ForEach(0..<4, id: \.self) { index in
                VStack(spacing: 8) {
                    Rectangle()
                        .fill(skeletonColor)
                        .frame(width: 40, height: 16)
                        .cornerRadius(2)
                    
                    // 첫 번째 탭은 선택된 상태
                    if index == 0 {
                        Rectangle()
                            .fill(accentColor)
                            .frame(height: 2)
                    } else {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 2)
                    }
                }
            }
            
            Spacer()
        }
        .padding(.top, 8)
        .background(backgroundColor)
    }
    
    // 콘텐츠 섹션 (개요 탭)
    private var contentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 개요 텍스트
            VStack(alignment: .leading, spacing: 8) {
                ForEach(0..<5, id: \.self) { _ in
                    Rectangle()
                        .fill(skeletonColor)
                        .frame(height: 14)
                        .cornerRadius(2)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            // 감독 정보
            HStack {
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 80, height: 14)
                    .cornerRadius(2)
                
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 120, height: 14)
                    .cornerRadius(2)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            // 관련 영상 섹션
            VStack(alignment: .leading, spacing: 12) {
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 100, height: 18)
                    .cornerRadius(2)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(0..<3, id: \.self) { _ in
                            VStack(spacing: 8) {
                                Rectangle()
                                    .fill(skeletonColor)
                                    .frame(width: 280, height: 160)
                                    .cornerRadius(8)
                                
                                Rectangle()
                                    .fill(skeletonColor)
                                    .frame(width: 200, height: 14)
                                    .cornerRadius(2)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .padding(.bottom, 16)
            
            // 출연 배우 섹션
            VStack(alignment: .leading, spacing: 12) {
                Rectangle()
                    .fill(skeletonColor)
                    .frame(width: 100, height: 18)
                    .cornerRadius(2)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<5, id: \.self) { _ in
                            VStack(spacing: 8) {
                                Circle()
                                    .fill(skeletonColor)
                                    .frame(width: 80, height: 80)
                                
                                Rectangle()
                                    .fill(skeletonColor)
                                    .frame(width: 60, height: 14)
                                    .cornerRadius(2)
                                
                                Rectangle()
                                    .fill(skeletonColor)
                                    .frame(width: 40, height: 12)
                                    .cornerRadius(2)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            
            // 푸터 스페이스
            Color.clear.frame(height: 50)
        }
    }
}

#Preview {
    DetailSkeletonView()
        .background(Color.black)
}
