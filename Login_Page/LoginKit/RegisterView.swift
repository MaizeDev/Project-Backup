//
//  RegisterView.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI

/// RegisterAccount
@available(iOS 17.0, *)
struct RegisterAccount: View {
    /// Properties
    /// 属性
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var isPerforming: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Let's get you started!")
                    .font(.title)
                
                Text("It's quick and easy.")
                    .textScale(.secondary)
            }
            .fontWeight(.medium)
            .padding(.top, 5)
            
            IconTextField(hint: "Email Address", symbol: "envelope", value: $email)
                .padding(.top, 10)
            
            IconTextField(hint: "Password", symbol: "lock", isPassword: true, value: $password)
            
            IconTextField(hint: "Confirm Password", symbol: "lock", isPassword: true, value: $passwordConfirmation)
            
            TaskButton(title: "Create Account") {
                try? await Task.sleep(for: .seconds(5))
            } onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(!isSignInButtonEnabled)
            .padding(.top, 15)
            

            Spacer(minLength: 0)
            
            /// YOUR Other Links for account Creation
            /// 用户创建其他链接
            HStack(spacing: 4) {
                Link("By creating an account, you agree to\nour terms of use and privacy policy.", destination: URL(string: "https://apple.com")!)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .underline()
            }
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(Color.primary.secondary)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading )
        .padding([.horizontal, .top], 20)
        .padding(.bottom, isiOS26 ? 0 : 10)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.7 : 1)
    }
    var isSignInButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && password == passwordConfirmation
    }
}
