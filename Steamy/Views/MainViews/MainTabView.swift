//
//  MainTabView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/25/21.
//

import SwiftUI


struct MainTabView: View {
    
    @State var email = ""
    @State var password = ""
    @State private var selection = 2
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(1)
            
            DiscoverView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Discover")
                }
                .tag(2)
            
            MessagingView()
                .tabItem {
                    Image(systemName: "bubble.left")
                    Text("Messaging")
                }
                .tag(3)
        }
    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
