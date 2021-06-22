//
//  SteamyApp.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/16/21.
//

import SwiftUI
import Firebase

@main
struct SteamyApp: App {
    
    init() {
     FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
