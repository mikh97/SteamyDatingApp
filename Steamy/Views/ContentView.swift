//
//  ContentView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/16/21.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        
        ZStack {
           Color(red: 0.94, green: 0.30, blue: 0.22)
            .ignoresSafeArea()
            
            VStack(alignment: .center) {
            Image("SteamyIcon")
            
                Text("Steamy")
                    .font(.system(size: 43, weight: .semibold, design: .rounded ))
                    .foregroundColor(Color.white)
                    
                    
            }
        
        }
    
        
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
    
}


