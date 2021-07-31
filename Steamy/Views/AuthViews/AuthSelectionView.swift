//
//  Sign_OR_Log_UIView.swift
//  Steamy
//
//  Created by Neeval Kumar on 6/18/21.
//

import SwiftUI

struct AuthSelectionView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                  
                    VStack{
                        
                        VStack {
                            Text("Steamy")
                                .font(.system(size: 30, weight: .light))
                            
                            Spacer()
                            
                            Text("Find your perfect match today.")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Text("By tapping Sign Up or Log In, you agree to our Terms and Policies.")
                                .font(.system(size: 16, weight: .light))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .padding()
                        
                        Spacer()

                        
                        NavigationLink(destination: SignUpView()){
                            Text("SIGN UP")
                                .font(Font.system(size: 15, weight: .semibold))
                                .foregroundColor(Color.red)
                                .frame(maxWidth: .infinity)
                                .padding([.top, .bottom], 10)
                                .background(Color.white)
                                .cornerRadius(6)
                                .padding([.top, .bottom], 10)
                                .padding()
                        }
                        
                        
                        NavigationLink(destination: LoginView()){
                            Text("LOG IN")
                                .font(Font.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding([.top, .bottom], 10)
                                .cornerRadius(6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.white, lineWidth: 1)
                                )
                                .padding([.top, .bottom], 10)
                                .padding()
                        }
                    }
                
                
            }
        }.accentColor(Color.red)
    }
}

struct AuthSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSelectionView()
    }
}
