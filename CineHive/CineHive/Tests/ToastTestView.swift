//
//  ToastTestView.swift
//  CineHive
//
//  Created by 이종민 on 3/23/25.
//

import SwiftUI

struct ToastTestView: View {
    @State private var viewModel = MovieViewModel()
    @State private var showToast = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("에러 테스트")
                    .font(.headline)

                Button("인터넷 끊김") {
                    viewModel.showError(NetworkError.networkError(URLError(.notConnectedToInternet)))
                }

                Button("타임아웃 에러") {
                    viewModel.showError(NetworkError.networkError(URLError(.timedOut)))
                }

                Button("서버 응답 오류 (500)") {
                    viewModel.showError(NetworkError.badResponse(statusCode: 500))
                }

                Button("디코딩 실패") {
                    viewModel.showError(NetworkError.decodingError(NSError(domain: "", code: 0)))
                }

                Button("인코딩 실패") {
                    viewModel.showError(NetworkError.encodingError(NSError(domain: "", code: 0)))
                }

                Button("알 수 없는 에러") {
                    viewModel.showError(NetworkError.unknown)
                }

                Divider().padding(.vertical, 8)

                Button("에러 초기화") {
                    viewModel.clearError()
                }
            }
            .padding()
        }
        .errorToast(message: viewModel.error, isPresented: $showToast)
        .onChange(of: viewModel.error) { _, newValue in
            if let newValue, !newValue.isEmpty {
                showToast = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        showToast = false
                        viewModel.clearError()
                    }
                }
            }
        }
    }
}

#Preview {
    ToastTestView()
}
