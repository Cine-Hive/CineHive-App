//
//  WritePostView.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct WritePostView: View {
    @State private var title = ""
    @State private var content = ""
    @State private var selectedCategory: String = "자유"
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert = false
    @State private var isSubmitting = false
    
    // 테마 색상
    private let backgroundColor = Color.black
    private let primaryColor = Color(hex: "#FF2F6E")
    private let textColor = Color.white
    private let secondaryColor = Color.gray
    
    private let categories = ["자유", "리뷰", "질문", "정보"]
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 16) {
                    // 카테고리 선택
                    HStack {
                        Text("카테고리")
                            .font(.headline)
                            .foregroundColor(textColor)
                        
                        Spacer()
                        
                        Picker("카테고리", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { category in
                                Text(category).tag(category)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .accentColor(primaryColor)
                    }
                    .padding(.horizontal, 16)
                    
                    // 제목 입력
                    TextField("제목을 입력하세요", text: $title)
                        .font(.headline)
                        .foregroundColor(textColor)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                    
                    // 내용 입력
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $content)
                            .scrollContentBackground(.hidden)
                            .background(Color.gray.opacity(0.1))
                            .foregroundColor(textColor)
                            .cornerRadius(8)
                            .frame(minHeight: 200)
                        
                        if content.isEmpty {
                            Text("내용을 입력하세요")
                                .foregroundColor(secondaryColor)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 8)
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
                
                if isSubmitting {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(primaryColor)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.5))
                }
            }
            .foregroundColor(textColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("취소") {
                        dismiss()
                    }
                    .foregroundColor(primaryColor)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("글 작성")
                        .font(.headline)
                        .foregroundColor(textColor)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("등록") {
                        submitPost()
                    }
                    .disabled(title.isEmpty || content.isEmpty)
                    .foregroundColor(title.isEmpty || content.isEmpty ? secondaryColor : primaryColor)
                }
            }
            .alert("게시글 등록", isPresented: $showAlert) {
                Button("확인", role: .cancel) {
                    dismiss()
                }
            } message: {
                Text("게시글이 등록되었습니다.")
            }
        }
    }
    
    // 게시글 등록 함수
    private func submitPost() {
        guard !title.isEmpty && !content.isEmpty else { return }
        
        isSubmitting = true
        
        // 실제로는 API 호출하여 서버에 게시글 저장
        // 현재는 임시로 딜레이 후 성공 처리
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isSubmitting = false
            showAlert = true
        }
    }
}

#Preview {
    WritePostView()
}
