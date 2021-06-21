//
//  LoginView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/21/21.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        ZStack {
            Color(red: 0.94, green: 0.30, blue: 0.22)
             .ignoresSafeArea()

            VStack{
                
            HStack {
                
                Button(action: {
                        print("Back Button Pressed")
                }) {
                    Label("Back", image: "Arrow_Back")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 13, weight: .semibold, design: .rounded ))
                        
                }

                
                Spacer(minLength: 50).frame(width: 20, height:10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Login")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 25, weight: .semibold, design: .rounded ))
               
                Spacer(minLength: 50).frame(width: 85, height:10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
            }
                
                VStack(alignment: .leading){
                    
                    Spacer(minLength: 30).frame(width: 100, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("Welcome Back!")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25, weight: .bold, design: .rounded ))
                        
                    Text("Sign in to continue")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 15, weight: .bold, design: .rounded ))
                    
                    
                }
                
                VStack{
                    
                    Spacer(minLength: 50).frame(width: 65, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("email", text: $email)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 0, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer(minLength: 50).frame(width: 65, height:5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("password", text: $password)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 75, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                            print("Forgot password pressed")
                    }) {
                        Text("Forgot password?")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    
                }
                    
                    Button(action: {
                            print("Login pressed")
                    }) {
                        Text("Login")
                            .frame(width: 250, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .border(Color.yellow, width:5)
                            .cornerRadius(40)
                            
                    }
                }
            }
                
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
}
