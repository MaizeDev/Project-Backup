//
//  ForgotPasswordView.swift
//  Login_Page
//
//  Created by wheat on 12/2/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ForgotPassword: View {
    @State private var emailAddress: String = ""
    @State private var isPerforming: Bool = false
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
            
            TaskButton(title: "Reset Password") {
                try? await Task.sleep(for: .seconds(5))
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
    }
}
