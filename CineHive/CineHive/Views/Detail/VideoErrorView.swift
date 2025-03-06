//
//  VideoErrorView.swift
//  CineHive
//
//  Created by 이종민 on 3/6/25.
//

import SwiftUI

struct VideoErrorView: View {
    var message: String = "비디오를 불러올 수 없습니다."
    var onDismiss: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(16)
                    }
                }
                
                Spacer()
                
                VStack {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                        .padding(.bottom, 16)
                    
                    Text(message)
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    VideoErrorView(onDismiss: {})
}
