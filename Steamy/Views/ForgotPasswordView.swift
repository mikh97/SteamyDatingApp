//
//  ForgotPasswordView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/28/21.
//

import SwiftUI
import ProgressHUD
import FirebaseAuth

struct ForgotPasswordView: View {
    
    @State var email = ""
    var body: some View {
        ZStack{
            Color(red: 0.94, green: 0.30, blue: 0.22)
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                
                Text("Reset Password.")
                    .font(.system(size: 43, weight: .semibold, design: .rounded ))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                
                Text("Please enter your email.")
                    .font(.system(size: 20, weight: .semibold, design: .rounded ))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                
                TextField("Email", text: $email)
                    .background(Color.white)
                    .cornerRadius(5)
                    .frame(width: 250, height: 75, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                NavigationLink(
                    destination: SignUpView(),
                    label: {Text("Submit").frame(width: 200, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .border(Color.yellow, width:5)
                        .cornerRadius(40).onTapGesture {
                            Auth.auth().sendPasswordReset(withEmail: email) { error in
                                // ...
                            }
                        }}
                )
            }
            
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
