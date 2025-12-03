//
//  ContentView.swift
//  Login_Page
//
//  Created by wheat on 11/28/25.
//

import SwiftUI

@available(iOS 17.0, *)
struct ContentView: View {
    var body: some View {
        LoginKit("user_log_status") {
            NavigationStack {
                List {
                    
                }
                .navigationTitle("Welcome Back")
            }
        }
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        ContentView()
    } else {
        // Fallback on earlier versions
    }
}
