//
//  ContentView.swift
//  Login_Page
//
//  Created by wheat on 11/28/25.
//

import SwiftUI


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
    ContentView()
}
