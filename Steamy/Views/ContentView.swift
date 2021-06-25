//
//  ContentView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/16/21.
//

import SwiftUI



struct ContentView: View {
    @State private var willMoveToNextScreen = false
    var body: some View {
        NavigationView{
        ZStack {
           Color(red: 0.94, green: 0.30, blue: 0.22)
            .ignoresSafeArea()
            
            VStack(alignment: .center) {
            Image("SteamyIcon")
            
                Text("Steamy")
                    .font(.system(size: 43, weight: .semibold, design: .rounded ))
                    .foregroundColor(Color.white)
                
                NavigationLink(destination: Sign_OR_Log_UIView().navigationBarHidden(true).navigationTitle(""))
                {
                    Text("Press Start Here")
                        .foregroundColor(.yellow)
                }
            }
        
        }
            
           
    }
}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
    
}


