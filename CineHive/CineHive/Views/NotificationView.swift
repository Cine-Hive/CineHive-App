//
//  NotificationView.swift
//  CineHive
//
//  Created by 이종민 on 3/16/25.
//

import SwiftUI

struct NotificationView: View {
    let message: String
    let icon: String
    @Binding var isPresented: Bool
    
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(CHColors.primaryColor)
            
            Text(message)
                .font(.system(size: 16))
                .foregroundColor(.white)
            
            Spacer()
            
            Button {
                withAnimation(.easeOut(duration: 0.3)) {
                    isPresented = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.7))
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.black.opacity(0.9))
        .cornerRadius(8)
        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(CHColors.primaryColor.opacity(0.5), lineWidth: 1)
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation(.easeOut(duration: 0.3)) {
                    isPresented = false
                }
            }
        }
    }
}

struct NotificationContainer: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let icon: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                VStack {
                    NotificationView(
                        message: message,
                        icon: icon,
                        isPresented: $isPresented
                    )
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(100)
                    .padding(.top, 60)
                    .padding(.horizontal, 16)
                    
                    Spacer()
                }
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPresented)
    }
}

extension View {
    func notification(isPresented: Binding<Bool>, message: String, icon: String = "bell.fill") -> some View {
        self.modifier(NotificationContainer(isPresented: isPresented, message: message, icon: icon))
    }
}
