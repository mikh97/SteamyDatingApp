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
    
    @State var email_sent = false
    @State var email = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack{
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
                .onTapGesture {
                    self.endEditing(true)
                }
            
            VStack {
                
                Text("Forgot your password?")
                    .foregroundColor(Color.red)
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 20)
                
                Text("We've got you covered.")
                    .foregroundColor(.orange)
                    .font(.system(size: 18, weight: .light))
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                
                
                Text("We'll email you a link that will instantly reset your password.")
                    .foregroundColor(.yellow)
                    .font(.system(size: 16, weight: .light))
                    .padding(.horizontal, 20)
//                    .padding(.vertical)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 20)
                
                TextField("Email", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(7)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(6)
                    .padding()
                    .keyboardType(.emailAddress)
                
                FullWidthTextButton(action: {
                    Api.User.resetPassword(email: email) {
                        ProgressHUD.showSuccess("If this user exists, we have sent you a password reset email.")
                    } onError: { errorMessage in
                        print(errorMessage)
                        ProgressHUD.showSuccess("If this user exists, we have sent you a password reset email.")
                    }

                }, text: "Send Email")
                
                Spacer()
                
                if (email_sent == true){
                    Text("Email Sent if Account exists.")
                        .font(.system(size: 20, weight: .semibold, design: .rounded ))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)                }
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
