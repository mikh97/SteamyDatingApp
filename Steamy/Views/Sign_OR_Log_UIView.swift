//
//  Sign_OR_Log_UIView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/18/21.
//

import SwiftUI

struct Sign_OR_Log_UIView: View {
    var body: some View {
        NavigationView{
        ZStack {
           Color(red: 0.94, green: 0.30, blue: 0.22)
            .ignoresSafeArea()
            
            VStack(alignment: .center) {
            
                Text("Find your Perfect Match Today")
                    .font(.system(size: 43, weight: .semibold, design: .rounded ))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                
                VStack{
                    Spacer(minLength: 50).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height:120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                   
                    NavigationLink(destination: LoginView()){
                        Text("LOGIN")
                            .frame(width: 200, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .border(Color.yellow, width:5)
                            .cornerRadius(40)
                    }
            
                            
                    
                    
                    Spacer(minLength: 50).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height:10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    
                    NavigationLink(destination: SignUpView()){
                        Text("SIGN UP")
                            .frame(width: 200, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.black)
                            .border(Color.white, width:5)
                            .cornerRadius(40)
                    }
                }
            }
        
        }
        }.accentColor(.yellow)
}
}

struct Sign_OR_Log_UIView_Previews: PreviewProvider {
    static var previews: some View {
        Sign_OR_Log_UIView()
    }
}
