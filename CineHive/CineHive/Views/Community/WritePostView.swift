//
//  WritePostView.swift
//  CineHive
//
//  Created by 이종민 on 3/19/25.
//

import SwiftUI

struct WritePostView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var selectedCategory: String = "자유"
    @State private var showDiscardAlert = false
    @State private var isSubmitting = false
    @State private var errorMessage: String? = nil
    @State private var showErrorAlert = false
    
    // 콜백 함수
    var onSubmit: @Sendable (String, String) async -> Void
    
    // 카테고리 옵션
    private let categories = ["자유", "리뷰", "질문", "정보"]
    
    // 테마 색상
    private let primaryColor = CHColors.primaryColor
    private let backgroundColor = CHColors.backgroundColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.gray
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    // 게시글 작성 폼
                    Form {
                        Section {
                            Picker("카테고리", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        } header: {
                            Text("카테고리")
                        }
                        .listRowBackground(CHColors.cardBackground)
                        
                        Section {
                            TextField("제목을 입력하세요", text: $title)
                                .foregroundColor(textColor)
                        } header: {
                            Text("제목")
                        }
                        .listRowBackground(CHColors.cardBackground)
                        
                        Section {
                            ZStack(alignment: .topLeading) {
                                if content.isEmpty {
                                    Text("내용을 입력하세요")
                                        .foregroundColor(secondaryColor)
                                        .padding(.top, 8)
                                        .padding(.leading, 5)
                                }
                                
                                TextEditor(text: $content)
                                    .foregroundColor(textColor)
                                    .frame(minHeight: 200)
                                    .background(CHColors.cardBackground)
                            }
                        } header: {
                            Text("내용")
                        }
                        .listRowBackground(CHColors.cardBackground)
                    }
                    .scrollContentBackground(.hidden)
                }
                
                if isSubmitting {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        ProgressView()
                            .tint(primaryColor)
                            .scaleEffect(1.5)
                            .padding()
                        
                        Text("게시글 등록 중...")
                            .foregroundColor(.white)
                    }
                    .frame(width: 200, height: 100)
                    .background(Color(white: 0.1))
                    .cornerRadius(12)
                }
            }
            .foregroundColor(textColor)
            .navigationTitle("게시글 작성")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if !title.isEmpty || !content.isEmpty {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    } label: {
                        Text("취소")
                            .foregroundColor(primaryColor)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        submitPost()
                    } label: {
                        Text("등록")
                            .fontWeight(.semibold)
                            .foregroundColor(isFormValid ? primaryColor : secondaryColor)
                    }
                    .disabled(!isFormValid)
                }
            }
            .alert("작성 취소", isPresented: $showDiscardAlert) {
                Button("계속 작성", role: .cancel) { }
                Button("취소", role: .destructive) {
                    dismiss()
                }
            } message: {
                Text("작성 중인 내용이 사라집니다. 정말 취소하시겠습니까?")
            }
            .alert("오류", isPresented: $showErrorAlert) {
                Button("확인", role: .cancel) { }
            } message: {
                Text(errorMessage ?? "알 수 없는 오류가 발생했습니다.")
            }
        }
    }
    
    // 폼 유효성 검사
    private var isFormValid: Bool {
        return !title.isEmpty && !content.isEmpty
    }
    
    // 게시글 등록
    private func submitPost() {
        guard isFormValid else { return }

        isSubmitting = true

        Task {
            await onSubmit(title, content)
            isSubmitting = false
        }
    }
}
