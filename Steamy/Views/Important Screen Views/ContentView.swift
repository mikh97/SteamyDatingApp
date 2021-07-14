//
//  ContentView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/16/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserApi

    var body: some View {
        Group {
            if user.signedIn {
                ProfileView()
                
                
            } else {
                Sign_OR_Log_UIView()
            }
        }
        .onAppear {
            user.signedIn = user.isSignedIn
        }
        
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
    
}


