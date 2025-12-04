//
//  Login_PageApp.swift
//  Login_Page
//
//  Created by wheat on 11/28/25.
//

import SwiftUI
import Firebase

@main
struct Login_PageApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
