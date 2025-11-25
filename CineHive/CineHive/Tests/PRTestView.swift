//
//  PRTestView.swift
//  CineHive
//
//  Created by 이종민 on 4/10/25.
//

import SwiftUI

struct PRTestView: View {
    // 이 부분은 상수로 선언되어야 더 효율적입니다
    var messageText = "PR 테스트용 뷰를 작성하였습니다."
    
    // 프로퍼티 명이 명확하지 않음
    @State private var a = false
    
    var body: some View {
        VStack(spacing: 20) {
            // 같은 텍스트를 반복적으로 사용 - 추출 가능
            Text(messageText)
                .font(.headline)
            Text(messageText)
                .font(.subheadline)
            Text(messageText)
                .font(.caption)
            
            // 조건문에 불필요한 true 비교
            Button(action: {
                if a == true {
                    a = false
                } else {
                    a = true
                }
                
                // 불필요한 디버그 출력
                print("버튼이 눌렸습니다!")
            }) {
                Text("상태 변경")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            // 명시적인 옵셔널 언래핑 - 더 안전한 방식으로 처리 가능
            if a {
                let optionalValue: String? = "표시될 텍스트"
                Text(optionalValue!)
            }
        }
        .padding()
        // 하드코딩된 값
        .frame(width: 300, height: 400)
    }
}

// PreviewProvider 없음

// 미사용 구조체
struct UnusedStruct {
    var unusedProperty: String = ""
    
    func unusedFunction() {
        // 아무것도 하지 않음
    }
}
