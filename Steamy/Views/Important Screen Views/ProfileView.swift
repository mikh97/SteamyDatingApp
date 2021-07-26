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
    @State private var selection = 2
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            InnerProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
                .tag(1)
            
            HomeView()
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


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
