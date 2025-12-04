//
//  LoginView.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI
import FirebaseAuth

/// Login View
/// 登录视图

struct LoginView: View {
    /// Properties
    /// 属性
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var createAccount: Bool = false
    @State private var forgotPassword: Bool = false
    @State private var userNotVerified: Bool = false
    @State private var isPerforming: Bool = false
    @State private var alert: AlertModal = .init(message: "")
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Welcome Back")
                    .font(.largeTitle)

                Text("Please Sign in to continue.")
                    .font(.callout)
            }
            .fontWeight(.medium)
            .padding(.top, 5)

            IconTextField(hint: "Email Address", symbol: "envelope", value: $email)
                .padding(.top, 10)

            IconTextField(hint: "Password", symbol: "lock", isPassword: true, value: $password)

            Button("Forgot Password?") {
                forgotPassword.toggle()
            }
            .padding(.top, 4)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .tint(.primary)

            TaskButton(title: "Sign In") {
                isFocused = false
                await login()
                
            } onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(!isSignInButtonEnabled)
            .padding(.top, 15)

            HStack(spacing: 4) {
                Text("Don't have an account?")

                Button("Sign Up Here") {
                    createAccount.toggle()
                }
                .underline()
            }
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(Color.primary)
            .frame(maxWidth: .infinity)

            Spacer(minLength: 6)

            /// YOUR Terms and Privacy Links!
            /// 您的条款和隐私链接
            HStack(spacing: 4) {
                Link("Terms of Service", destination: URL(string: "https://apple.com")!)
                    .underline()
                Text("&")

                Link("Privacy Policy", destination: URL(string: "http://apple.com")!)
                    .underline()
            }
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(Color.primary.secondary)
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.horizontal, .top], 20)
        .padding(.bottom, isiOS26 ? 0 : 10)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.7 : 1)
        .sheet(isPresented: $createAccount) {
            RegisterAccount()
                .presentationDetents([.height(400)])
                .presentationBackground(.background)
                /// Sinec iOS 26 adpats its corner radius to it's device's corner radius!
                .presentationCornerRadius(isiOS26 ? nil : 30)
        }
        .sheet(isPresented: $forgotPassword) {
            ForgotPassword()
                .presentationDetents([.height(230)])
                .presentationBackground(.background)
                /// Sinec iOS 26 adpats its corner radius to it's device's corner radius!
                .presentationCornerRadius(isiOS26 ? nil : 30)
        }
        .sheetAlert(
            isPresented: $userNotVerified,
            prominentSymbol: "envelope.badge",
            title: "Email Verification",
            message: "We have sent a verification email to\nyour address. Please check your inbox.",
            buttonTitle: "Verified?",
            buttonAction: {
            }
        )
        .customAlert($alert)
        .focused($isFocused)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
    
    private func login() async {
        do {
            let auth = Auth.auth()
            let result = try await auth.signIn(withEmail: email, password: password)
            if result.user.isEmailVerified {
                /// Success Login
            } else {
                userNotVerified = true
            }
        } catch {
            alert.message = error.localizedDescription
            alert.show = true
        }
    }

    var isSignInButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty
    }
}
