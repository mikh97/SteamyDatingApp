//
//  ProfileView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/25/21.
//

import SwiftUI


struct ProfileView: View {
    
    @State var email = ""
    @State var password = ""
    var body: some View {
        
        TabView {
            
            InnerProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            MatchScreenView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Discover")
                }
            
            MessagingView()
                .tabItem {
                    Image(systemName: "bubble.left")
                    Text("Messaging")
                }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
