//
//  ToastView.swift
//  CineHive
//
//  Created by 이종민 on 3/31/25.
//

import SwiftUI

// 토스트 유형 정의
enum ToastType {
    case success
    case error
    case warning
    case info

    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "exclamationmark.triangle.fill"
        case .warning: return "exclamationmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }

    var accentColor: Color {
        switch self {
        case .success: return CHColors.Feedback.success
        case .error: return CHColors.Feedback.error
        case .warning: return CHColors.Feedback.warning
        case .info: return CHColors.Feedback.info
        }
    }

    var feedbackType: UINotificationFeedbackGenerator.FeedbackType? {
        switch self {
        case .success: return .success
        case .error: return .error
        case .warning: return .warning
        case .info: return nil
        }
    }
}

struct ToastView: View {
    let message: String
    let toastType: ToastType
    let actionTitle: String?
    let action: (() -> Void)?

    init(
        message: String,
        toastType: ToastType = .info,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.message = message
        self.toastType = toastType
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: toastType.iconName)
                .foregroundColor(.white)
                .font(.system(size: 18))

            Text(message)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)

            Spacer()

            if let actionTitle, let action {
                Button(actionTitle) {
                    action()
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(.white.opacity(0.2))
                .clipShape(Capsule())
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(toastType.accentColor.opacity(0.9))
                .shadow(color: CHColors.shadowColor, radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 50)
    }
}

extension View {
    func toast(
        message: String?,
        isPresented: Binding<Bool>,
        toastType: ToastType = .info,
        duration: Double = 2.5,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue, let message = message {
                VStack {
                    Spacer()
                    ToastView(
                        message: message,
                        toastType: toastType,
                        actionTitle: actionTitle,
                        action: action
                    )
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isPresented.wrappedValue)
                    .gesture(
                        DragGesture()
                            .onEnded { gesture in
                                if gesture.translation.height > 20 {
                                    withAnimation {
                                        isPresented.wrappedValue = false
                                    }
                                }
                            }
                    )
                }
                .transition(.identity)
                .onAppear {
                    if let feedbackType = toastType.feedbackType {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(feedbackType)
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation(.easeOut) {
                            isPresented.wrappedValue = false
                        }
                    }
                }
            }
        }
    }

    func errorToast(
        message: String?,
        isPresented: Binding<Bool>,
        duration: Double = 2.5,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        toast(
            message: message,
            isPresented: isPresented,
            toastType: .error,
            duration: duration,
            actionTitle: actionTitle,
            action: action
        )
    }
}

struct ToastPreview: View {
    @State private var showSuccessToast = false
    @State private var showErrorToast = false
    @State private var showInfoToast = false

    var body: some View {
        VStack(spacing: 20) {
            Button("성공 토스트 표시") {
                showSuccessToast = true
            }
            .padding()

            Button("오류 토스트 표시") {
                showErrorToast = true
            }
            .padding()

            Button("정보 토스트 표시") {
                showInfoToast = true
            }
            .padding()
        }
        .toast(
            message: "회원가입이 성공적으로 완료되었습니다",
            isPresented: $showSuccessToast,
            toastType: .success
        )
        .toast(
            message: "이메일 또는 비밀번호가 올바르지 않습니다",
            isPresented: $showErrorToast,
            toastType: .error,
            actionTitle: "다시 시도",
            action: { print("다시 시도") }
        )
        .toast(
            message: "새로운 기능이 추가되었습니다",
            isPresented: $showInfoToast,
            toastType: .info
        )
    }
}

#Preview {
    ToastPreview()
}
