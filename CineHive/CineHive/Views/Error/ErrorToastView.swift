//
//  ErrorToastView.swift
//  CineHive
//
//  Created by 이종민 on 3/23/25.
//

import SwiftUI

struct ErrorToastView: View {
    let message: String
    let accentColor: Color
    let iconName: String
    let actionTitle: String?
    let action: (() -> Void)?

    init(
        message: String,
        accentColor: Color = .red,
        iconName: String = "exclamationmark.triangle.fill",
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.message = message
        self.accentColor = accentColor
        self.iconName = iconName
        self.actionTitle = actionTitle
        self.action = action
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
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
                .fill(accentColor.opacity(0.9))
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }
}

extension View {
    func errorToast(
        message: String?,
        isPresented: Binding<Bool>,
        duration: Double = 2.5,
        accentColor: Color = .red,
        iconName: String = "exclamationmark.triangle.fill",
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue, let message = message {
                VStack {
                    Spacer()
                    ErrorToastView(
                        message: message,
                        accentColor: accentColor,
                        iconName: iconName,
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
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation(.easeOut) {
                            isPresented.wrappedValue = false
                        }
                    }
                }
            }
        }
    }
}
