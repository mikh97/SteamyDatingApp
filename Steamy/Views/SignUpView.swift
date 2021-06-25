//
//  SignUpView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/20/21.
//

import SwiftUI

struct SignUpView: View {
    
    // these states need to be somehow be integrated with the database, please read more on that
    
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirm_password: String = ""
    
    var body: some View {
        
        
        ZStack {
            Color(red: 0.94, green: 0.30, blue: 0.22)
             .ignoresSafeArea()

            VStack{
                
            HStack {
                
                
                Text("Sign Up")
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 50, weight: .semibold, design: .rounded ))
            
                
            }
                
           
                VStack(alignment: .leading){
                    
                    Spacer(minLength: 30).frame(width: 100, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Text("Lets Get Started!")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 25, weight: .bold, design: .rounded ))
                        
                    Text("Create an account to use steamy")
                        .foregroundColor(.yellow)
                        .font(.system(size: 15, weight: .bold, design: .rounded ))
                }
                
                VStack{
                    
                    Spacer(minLength: 50).frame(width: 65, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("First Name", text: $first_name)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 0, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer(minLength: 50).frame(width: 65, height:5, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("Last Name", text: $last_name)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 75, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer(minLength: 50).frame(width: 65, height:0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("Email", text: $email)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 15, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer(minLength: 50).frame(width: 65, height:10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("Password", text: $password)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 55, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Spacer(minLength: 50).frame(width: 65, height:0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    TextField("Confirm Password", text: $confirm_password)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                        .cornerRadius(5)
                        .frame(width: 250, height: 35, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                }
                
                VStack{
                    Spacer(minLength: 50).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height:50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Button(action: {
                            print("Create Pressed")
                    }) {
                        Text("Create")
                            .frame(width: 250, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding()
                            .background(Color.yellow)
                            .foregroundColor(.white)
                            .border(Color.yellow, width:5)
                            .cornerRadius(40)
                            
                    }
                    
                    Spacer(minLength: 50).frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height:10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Button(action: {
                            print("Sign Up Pressed")
                    }) {
                        
                        Label("Sign up with facebook", image: "facebooklogo")
                            .frame(width: 250, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .border(Color.blue, width:5)
                            .cornerRadius(40)
                        
                            
                    }
                    Spacer(minLength: 50).frame(width: 200, height:30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Button(action: {
                            print("Login check Pressed")
                    }) {
                        Text("Already have an account? Log in here.")
                            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    
                }
                    Spacer(minLength: 50).frame(width: 200, height:20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                }
            
            }
        
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
