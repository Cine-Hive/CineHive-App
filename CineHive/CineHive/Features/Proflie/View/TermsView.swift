//
//  TermsView.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import SwiftUI

struct TermsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedSection: TermsSection = .purpose
    
    var body: some View {
        NavigationStack {
            ZStack {
                CHColors.backgroundColor.ignoresSafeArea()
                
                VStack(spacing: 0) {
                    sectionSelector()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            Text("CineHive 이용약관")
                                .font(.title2.bold())
                                .foregroundColor(CHColors.textColor)
                            
                            sectionContent(for: selectedSection)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .id(selectedSection)
                    }
                }
            }
            .navigationTitle("이용약관")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("닫기") { dismiss() }
                        .foregroundStyle(CHColors.textColor)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        ForEach(TermsSection.allCases, id: \.self) { section in
                            Button(section.rawValue) {
                                withAnimation { selectedSection = section }
                            }
                        }
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundStyle(CHColors.textColor)
                    }
                }
            }
        }
    }
    
    private func sectionSelector() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(TermsSection.allCases, id: \.self) { section in
                    Button {
                        withAnimation { selectedSection = section }
                    } label: {
                        Text(section.rawValue)
                            .font(.footnote)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .foregroundColor(selectedSection == section ? .white : CHColors.secondaryColor)
                            .background(
                                selectedSection == section ? CHColors.primaryColor : Color.gray.opacity(0.1)
                            )
                            .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
        }
        .background(Color.black.opacity(0.05))
    }
    
    @ViewBuilder
    private func sectionContent(for section: TermsSection) -> some View {
        if let content = TermsContent.contents[section] {
            sectionTitle(section.rawValue)
            ForEach(content, id: \.self) { paragraph in
                Text(paragraph)
                    .font(.body)
                    .foregroundColor(CHColors.textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        } else {
            sectionTitle(section.rawValue)
            Text("해당 섹션의 내용은 준비 중입니다.")
                .font(.body)
                .foregroundColor(CHColors.textColor)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundColor(CHColors.textColor)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    TermsView()
        .preferredColorScheme(.dark)
}
