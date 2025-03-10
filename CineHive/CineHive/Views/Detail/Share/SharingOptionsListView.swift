//
//  SharingOptionsListView.swift
//  CineHive
//
//  Created by 이종민 on 3/8/25.
//

import SwiftUI
import MessageUI
import LinkPresentation
import KakaoSDKShare
import KakaoSDKTemplate
import KakaoSDKCommon

struct SharingOptionsListView: View {
    let movie: MovieDetail
    @StateObject private var viewModel: SharingOptionsViewModel
    
    init(movie: MovieDetail) {
        self.movie = movie
        _viewModel = StateObject(wrappedValue: SharingOptionsViewModel(movie: movie))
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ShareOptionButton(share: .copyURL) {
                    viewModel.copyURL()
                }
                
                ShareOptionButton(share: .kakaotalk) {
                    viewModel.shareWithKakaoTalk()
                }
                
                ShareOptionButton(share: .message) {
                    viewModel.sendMessage()
                }
                
                ShareOptionButton(share: .systemShare) {
                    viewModel.systemShare()
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
        .sheet(isPresented: $viewModel.isShowingMessageView) {
            MessageComposeView(movie: movie, isPresented: $viewModel.isShowingMessageView)
        }
        .sheet(isPresented: $viewModel.isShowingShareSheet) {
            if let movieURL = URL(string: "https://cinehive.app/movies/\(movie.id)") {
                ShareSheet(activityItems: [movieURL, movie.title])
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .overlay(
            ToastView(message: viewModel.toastMessage, isShowing: $viewModel.showToast)
        )
    }
}

// 메시지 컴포저 뷰
struct MessageComposeView: UIViewControllerRepresentable {
    let movie: MovieDetail
    @Binding var isPresented: Bool
    
    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = context.coordinator
        
        // 메시지 내용 설정
        let movieURL = "https://cinehive.app/movies/\(movie.id)"
        composeVC.body = "CineHive에서 '\(movie.title)'을(를) 확인해보세요!\n\(movieURL)"
        
        return composeVC
    }
    
    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        let parent: MessageComposeView
        
        init(parent: MessageComposeView) {
            self.parent = parent
        }
        
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            // 메시지 전송 완료 후 처리
            parent.isPresented = false
        }
    }
}

//MARK: - 시스템 공유 시트
struct ShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// 토스트 뷰 구현
struct ToastView: View {
    let message: String
    @Binding var isShowing: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isShowing {
                Text(message)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .padding(.bottom, 60)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeInOut(duration: 0.3), value: isShowing)
            }
        }
    }
}

#Preview {
    SharingOptionsListView(movie: MovieDetail.dummy)
        .background(.black)
}
