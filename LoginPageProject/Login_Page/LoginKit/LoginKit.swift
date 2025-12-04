//
//  SwiftUIView.swift
//  Login_Page
//
//  Created by wheat on 11/28/25.
//

import SwiftUI

struct LoginKit<Content: View>: View {
    init(_ appStorageID: String, @ViewBuilder content: @escaping () -> Content) {
        _isLoggedIn = .init(wrappedValue: false, appStorageID)
        /// After Login Content
        /// 登录后内容
        self.content = content()
    }

    private var content: Content
    @AppStorage private var isLoggedIn: Bool // 是否登录

    var body: some View {
        ZStack {
            if isLoggedIn {
                content
            } else {
                /// Login/Register View
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
