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
    var body: some View {
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
                        
                        TextField("Email", text: $email)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .background(Color.white)
                            .cornerRadius(5)
                            .frame(width: 250, height: 0, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Spacer(minLength: 50).frame(width: 65, height:5, alignment: .center)
                        
                        SecureField("Password", text: $password)
                            .background(Color.white)
                            .cornerRadius(5)
                            .frame(width: 250, height: 75, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        NavigationLink(destination: ForgotPasswordView()){
                            Text("Forgot Password?")
                                .foregroundColor(.white)
                        }
                        
                        Spacer(minLength: 50).frame(width: 20, height:100, alignment: .center)
                        
                        
                        Button(action: {
                            print("Login pressed")
                            
                            signIn {
                                
                            } onError: { errorMessage in
                                ProgressHUD.showError(errorMessage)
                            }
                            
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
                        
                        
//                        if (authentication == true){
//                            NavigationLink(destination: ProfileView(),isActive:$authentication, label: {Text("Login Sucessfull. Continue")
//                                .frame(width: 250, height: 0, alignment: .center)
//                                .font(.system(size: 20, weight: .semibold, design: .rounded))
//                                .padding()
//                                .background(Color.yellow)
//                                .foregroundColor(.white)
//                                .border(Color.yellow, width:5)
//                                .cornerRadius(40)
//                            })
//                        }
//
//
//
//
//                        //Back to signup Page
//
                        Spacer()
                        
                        NavigationLink(destination: SignUpView()){
                            Text("Do not have an account? Sign up.")
                                .foregroundColor(.white)
                        }
                        Spacer(minLength: 50).frame(width: 20, height:100, alignment: .center)
                    }
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}

