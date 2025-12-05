//
//  RegisterView.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI
import FirebaseAuth

/// RegisterAccount

struct RegisterAccount: View {
    var onSuccessLogin: () -> () = { }
    /// Properties
    /// 属性
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var isPerforming: Bool = false
    @State private var alert: AlertModal = .init(message: "")
    @State private var userVerificationModal: Bool = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) var dismiss

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
                isFocused = false
                await createNewAccount()
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding([.horizontal, .top], 20)
        .padding(.bottom, isiOS26 ? 0 : 10)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.7 : 1)
        .focused($isFocused)
        .customAlert($alert)
        .sheetAlert(
            isPresented: $userVerificationModal,
            prominentSymbol: "envelope.badge",
            title: "Email Verification",
            message: "We have sent a verification email to\nyour address. Please check your inbox.",
            buttonTitle: "Verified?",
            buttonAction: {
                /// Checking if the email is verified
                /// 检查邮箱是否验证
                if let user = Auth.auth().currentUser {
                    try? await user.reload()
                    if user.isEmailVerified {
                        /// Sucess Login
                        print("Success!")
                        dismiss()
                        /// Optional: Allowing to have dismiss animation
                        /// 可选: 允许显示隐藏动画
                        try? await Task.sleep(for: .seconds(0.25))
                        onSuccessLogin()
                    }
                }
            }
        )
        /// Disabling Interractive dismiss when keyboard is active/isPerforming action
        .interactiveDismissDisabled(isFocused || isPerforming)
    }
    
    private func createNewAccount() async {
        do {
            let auth = Auth.auth()
            let result = try await auth.createUser(withEmail: email, password: password)
            /// Sending Email Verification Link to confirm user!
            try await result.user.sendEmailVerification()
            userVerificationModal = true
        } catch {
            /// You can do additional checks here, such as if a user is created by failed to send email, then in that case you can delete that user and so on!
            /// For now, I'm keeping it simple!
            alert.message = error.localizedDescription
            alert.show = true
        }
    }

    var isSignInButtonEnabled: Bool {
        !email.isEmpty && !password.isEmpty && password == passwordConfirmation
    }
}
