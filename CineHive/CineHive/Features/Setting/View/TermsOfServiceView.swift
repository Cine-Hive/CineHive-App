//
//  TermsOfServiceView.swift
//  CineHive
//
//  Created by 이종민 on 4/3/25.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    private let backgroundColor = CHColors.backgroundColor
    private let textColor = CHColors.textColor
    private let secondaryColor = CHColors.secondaryColor
    
    var body: some View {
}

#Preview {
    TermsOfServiceView()
        .preferredColorScheme(.dark)
}
