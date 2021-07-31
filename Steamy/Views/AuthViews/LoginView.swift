//
//  LoginView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/21/21.
//

import SwiftUI
import FirebaseAuth
import ProgressHUD

struct LoginView: View {
    
//    private let User: UserServiceProtocol
//
//    init(User: UserServiceProtocol = Api.User.signIn()){
//        self.User = User
//    }
    
//    @State var authentication = false
    
    @EnvironmentObject var user: UserApi
    
    func signIn(onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            ProgressHUD.showError("Email/Password missing.")
            return
        }
        
        ProgressHUD.show()
        user.signIn(email: email, password: password) {
            ProgressHUD.dismiss()
            user.loadCardPeople()
//            authentication = true
            onSuccess()
        } onError: { errorMessage in
            onError(errorMessage)
        }
    }
    
    @State var email: String = ""
    @State var password: String = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            
            Color(colorScheme == .dark ? .black : .white)
                .ignoresSafeArea()
                .onTapGesture {
                    self.endEditing(true)
                }
            
            VStack {
                
                Text("Login")
                    .foregroundColor(Color.red)
                    .font(.system(size: 50, weight: .bold))
                
                
                Spacer(minLength: 30).frame(width: 10, height:0, alignment: .center)
                
                VStack(alignment: .center){
                    
                    Spacer(minLength: 30).frame(width: 100, height:60, alignment: .center)
                    
                    Text("Welcome Back!")
                        .foregroundColor(Color.orange)
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.bottom)
                    
                    
                    Text("Sign in to continue.")
                        .foregroundColor(.yellow)
                        .font(.system(size: 25, weight: .light))
                    
                    Spacer(minLength: 50).frame(width: 20, height:60, alignment: .center)
                }
                
                VStack{
                    
                    Spacer().frame(height:50)
                    
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                    Spacer().frame(height:10)
                    
                    SecureField("Password", text: $password)
                        .padding(7)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(6)
                        .frame(width: 300)
                    
                    Spacer().frame(height:10)
                    
                    NavigationLink(destination: ForgotPasswordView()){
                        Text("Trouble logging in to your account?")
                            .foregroundColor(Color.orange)
                            .font(.system(size: 16, weight: .light))
                    }
                    .padding()
                    
                    Spacer().frame(height:50)
                    
                    VStack {
                        Button(action: {
                            print("Login pressed")
                            
                            signIn {
                                
                            } onError: { errorMessage in
                                ProgressHUD.showError(errorMessage)
                            }
                            
                        }) {
                            
                            Text("Log In")
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
                        
                        NavigationLink(destination: SignUpView()){
                            Text("Don't have an account? Sign up here.")
                                .foregroundColor(Color.red)
                        }
                        
                        Spacer().frame(height:20)
                    }
                }
                
            }
        }
        .padding(.top, 1)
        .navigationBarBackButtonHidden(true)
    }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}

