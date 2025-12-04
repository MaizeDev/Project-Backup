//
//  ForgotPasswordView.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI
import FirebaseAuth

struct ForgotPassword: View {
    @State private var emailAddress: String = ""
    @State private var isPerforming: Bool = false
    @State private var alert: AlertModal = .init(message: "")
    @Environment(\.dismiss) var dismiss
    c
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Forgot Password? ")
                    .font(.title)

                Text("Don't worry! We'll send you a link to reset it.")
                    .textScale(.secondary)
                    .foregroundStyle(.gray)
            }
            .fontWeight(.medium)

            IconTextField(hint: "Email Address", symbol: "envelope", value: $emailAddress)
                .padding(.top, 10)

            TaskButton(title: "Send Reset Link") {
                isFocused = false
                await sendPasswordResetLink()
            } onStatusChange: { isLoading in
                isPerforming = isLoading
            }
            .disabled(emailAddress.isEmpty)
            .padding(.top, 5)
        }
        .padding(.horizontal, 20)
        .padding(.top, 25)
        .allowsHitTesting(!isPerforming)
        .opacity(isPerforming ? 0.7 : 1)
        .focused($isFocused)
        .customAlert($alert)
        /// Disabling Interractive dismiss when keyboard is active/isPerforming action
        .interactiveDismissDisabled(isFocused || isPerforming)
    }
    
    private func sendPasswordResetLink() async {
        do {
            let auth = Auth.auth()
            try await auth.sendPasswordReset(withEmail: emailAddress)
            /// Success with a greeting!
            alert = .init(icon: "checkmark.circle.fill", title: "Email Sent!", message: "check your email for alink to reset your password.", show: true, action: {
                dismiss()
            })
        } catch {
            alert.message = error.localizedDescription
            alert.show = true
        }
    }
}
