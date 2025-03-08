import SwiftUI
import MessageUI
import LinkPresentation
import KakaoSDKShare
import KakaoSDKTemplate
import KakaoSDKCommon

struct SharingOptionsListView: View {
    let movie: MovieDetail
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingMessageView = false
    @State private var isShowingShareSheet = false
    @State private var showToast = false
    @State private var toastMessage = ""
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ShareOptionButton(share: .copyURL) {
                    handleCopyURL()
                }
                
                ShareOptionButton(share: .kakaotalk) {
                    handleKakaoTalk()
                }
                
                ShareOptionButton(share: .message) {
                    handleMessage()
                }
                
                ShareOptionButton(share: .systemShare) {
                    handleSystemShare()
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 4)
        }
        .sheet(isPresented: $isShowingMessageView) {
            MessageComposeView(movie: movie, isPresented: $isShowingMessageView)
        }
        .sheet(isPresented: $isShowingShareSheet) {
            if let movieURL = URL(string: "https://cinehive.app/movies/\(movie.id)") {
                ShareSheet(activityItems: [movieURL, movie.title])
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        
        .overlay(
            ToastView(message: toastMessage, isShowing: $showToast)
        )
    }
    
    // MARK: - 공유 옵션별 함수
    private func handleCopyURL() {
        let movieURL = "https://cinehive.app/movies/\(movie.id)"
        UIPasteboard.general.string = movieURL
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        // 토스트 메시지 표시
        toastMessage = "URL이 복사되었습니다"
        showToast = true
        
        // 2초 후에 토스트 메시지 숨기기
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showToast = false
        }
    }
    
    private func handleKakaoTalk() {
        // 카카오톡 공유 로직 구현 (KakaoSDK 사용)
    }
    
    private func showErrorToast(message: String) {
        DispatchQueue.main.async {
            self.toastMessage = message
            self.showToast = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showToast = false
            }
        }
    }
    
    private func handleMessage() {
        // MFMessageComposeViewController로 SMS/MMS 공유
        if MFMessageComposeViewController.canSendText() {
            isShowingMessageView = true
        } else {
            // SMS 서비스를 사용할 수 없는 경우 (시뮬레이터 등)
            print("SMS 서비스를 사용할 수 없습니다.")
            // 사용자에게 알림 표시
        }
    }
    
    private func handleSystemShare() {
        // 시스템 공유 시트 표시
        isShowingShareSheet = true
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
