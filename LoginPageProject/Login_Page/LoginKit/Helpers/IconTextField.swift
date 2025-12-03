//
//  IconTextField.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI

// MARK: - Custom Icon TextField With Background
/// 带图标的自定义背景文本框
struct IconTextField: View {
    var hint: String
    var symbol: String
    var isPassword: Bool = false
    @Binding var value: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.callout)
                .foregroundStyle(.gray)
                .frame(width: 30)
            
            Group {
                if isPassword {
                    SecureField(hint, text: $value)
                } else {
                    TextField(hint, text: $value)
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(.capsule)
    }
}
