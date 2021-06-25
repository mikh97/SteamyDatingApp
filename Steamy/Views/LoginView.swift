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
        NavigationView{
            ZStack {
                
                Color(red: 0.94, green: 0.30, blue: 0.22)
                    .ignoresSafeArea()
                
                VStack{
                    
                    
                    HStack{
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 50, weight: .semibold, design: .rounded ))
                        
                    }
                    
                    Spacer(minLength: 30).frame(width: 10, height:0, alignment: .center)
                    
                    VStack(alignment: .center){
                        
                        Spacer(minLength: 30).frame(width: 100, height:60, alignment: .center)
                        
                        Text("Welcome Back!")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded ))
                            
                            
                        Text("Sign in to continue")
                            .foregroundColor(.yellow)
                            .font(.system(size: 25, weight: .bold, design: .rounded ))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        
                        Spacer(minLength: 50).frame(width: 20, height:60, alignment: .center)
                    }
                    
                    VStack{
                        
                        Spacer(minLength: 50).frame(width: 65, height:50, alignment: .center)
                        
                        TextField("email", text: $email)
                            .background(Color.white)
                            .cornerRadius(5)
                            .frame(width: 250, height: 0, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Spacer(minLength: 50).frame(width: 65, height:5, alignment: .center)
                        
                        TextField("password", text: $password)
                            .background(Color.white)
                            .cornerRadius(5)
                            .frame(width: 250, height: 75, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            print("Forgot password pressed")
                        }) {
                            Text("Forgot password?")
                                .foregroundColor(.white)
                            
                        }
                        
                        Spacer(minLength: 50).frame(width: 20, height:100, alignment: .center)
                        
                        Button(action: {
                            print("Login pressed")
                        }) {
                            Text("Login")
                                .frame(width: 250, height: 0, alignment: .center)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .padding()
                                .background(Color.yellow)
                                .foregroundColor(.white)
                                .border(Color.yellow, width:5)
                                .cornerRadius(40)
                            
                        }
                        
                        //Back to signup Page
                        
                        NavigationLink(destination: SignUpView()){
                            Text("Do not have an account? Sign up.")
                                .foregroundColor(.white)
                        }
                        
                        Spacer(minLength: 50).frame(width: 20, height:100, alignment: .center)
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

