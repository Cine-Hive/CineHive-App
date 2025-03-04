//
//  DetailTabView.swift
//  CineHive
//
//  Created by 이종민 on 3/4/25.
//

import SwiftUI

struct DetailTabView: View {
    @Binding var selectedTab: DetailTab
    let accentColor: Color
    let textColor: Color
    let secondaryTextColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            ForEach(DetailTab.allCases, id: \.self) { tab in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 8) {
                        Text(tab.title)
                            .font(.system(size: 16, weight: selectedTab == tab ? .bold : .regular))
                            .foregroundColor(selectedTab == tab ? textColor : secondaryTextColor)
                        Rectangle()
                            .fill(selectedTab == tab ? accentColor : Color.clear)
                            .frame(height: 2)
                    }
                }
            }
            Spacer()
        }
        .padding(.top, 8)
    }
}

#Preview {
    DetailTabView(selectedTab: .constant(.overview), accentColor: .red, textColor: .white, secondaryTextColor: .gray)
        .background(.black)
}
