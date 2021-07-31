//
//  SignUpView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/20/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

struct SignUpView: View {
    
    // these states need to be somehow be integrated with the database, please read more on that
    
    @State var first_name: String = ""
    @State var last_name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirm_password: String = ""
    
    @EnvironmentObject var user: UserApi
    
    @Environment(\.colorScheme) var colorScheme
    
    func signUp(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard !first_name.isEmpty,
              !last_name.isEmpty,
              !email.isEmpty,
              !password.isEmpty,
              !confirm_password.isEmpty
        else {
            ProgressHUD.showError("Complete all the fields.")
            return
        }
        
        // Make sure user's first and last name does not contain integers (Mikhail)
        let firstNameCharacters = CharacterSet.decimalDigits
        let firstNameRange = first_name.rangeOfCharacter(from: firstNameCharacters)
        if firstNameRange != nil {
            ProgressHUD.showError("Name cannot contain integer.")
            return
        }
        let lastNameCharacters = CharacterSet.decimalDigits
        let lastNameRange = last_name.rangeOfCharacter(from: lastNameCharacters)
        if lastNameRange != nil {
            ProgressHUD.showError("Name cannot contain integer.")
            return
        }
        
        // Make sure user's password is not too long or too short (Mikhail)
        if password != confirm_password {
            ProgressHUD.showError("Password not match.")
            return
        } else if password.count < 6 {
            ProgressHUD.showError("Password too short.")
            return
        } else if password.count >= 20 {
            ProgressHUD.showError("Password too long.")
            return
        }
        
        ProgressHUD.show()
        user.signUp(email: email, password: password, firstName: first_name, lastName: last_name) {
            ProgressHUD.dismiss()
            onSuccess()
        } onError: { errorMessage in
            onError(errorMessage)
        }
    }
    
    
    var body: some View {
        
        ZStack {
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
                .onTapGesture {
                    self.endEditing(true)
                }
            
            VStack {
                Text("Sign Up")
                    .foregroundColor(Color.red)
                    .font(.system(size: 50, weight: .bold))
                
                Spacer().frame(height:50)
                
                Text("Let's Get Started!")
                    .foregroundColor(Color.orange)
                    .font(.system(size: 25, weight: .semibold))
                    .padding(.bottom)
                
                Text("Create an account to use steamy.")
                    .foregroundColor(.yellow)
                    .font(.system(size: 25, weight: .light))
                
                VStack{
                    
                    Spacer().frame(height:50)
                    
                    TextField("First Name", text: $first_name)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                    Spacer().frame(height:10)
                    
                    TextField("Last Name", text: $last_name)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                    Spacer().frame(height:10)
                    
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                    Spacer().frame(height:10)
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                    Spacer().frame(height:10)
                    
                    SecureField("Confirm Password", text: $confirm_password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                }
                
                VStack{
                    Spacer().frame(height:50)
                    
                    Button(action: {
                        print("Create Pressed")
                        signUp {
                        } onError: { errorMessage in
                            ProgressHUD.showError(errorMessage)
                        }
                        
                    }) {
                        Text("Begin Journey")
                            .font(Font.system(size: 15, weight: .semibold))
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding([.top, .bottom], 10)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(6)
                            .padding([.top, .bottom], 10)
                            .padding()
                        
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginView()){
                        Text("Already have an account? Log in here.")
                            .foregroundColor(Color.red)
                    }
                    
                    Spacer().frame(height:20)
                }
                
            }
            
        }
        .padding(.top, 1)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
