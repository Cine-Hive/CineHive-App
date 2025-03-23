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
    
    init(message: String, accentColor: Color = .red) {
        self.message = message
        self.accentColor = accentColor
    }
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.white)
                .font(.system(size: 18))
            
            Text(message)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Spacer()
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
    func errorToast(message: String?, isPresented: Binding<Bool>, duration: Double = 2.5, accentColor: Color = .red) -> some View {
        ZStack {
            self
            if isPresented.wrappedValue, let message = message {
                VStack {
                    Spacer()
                    ErrorToastView(message: message, accentColor: accentColor)
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
                    // Haptic feedback when error appears
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                    
                    // Auto dismiss after specified duration
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
