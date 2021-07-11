//
//  EditProfileView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/5/21.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var age: String=""
    @State var gender: String=""
    @State var location: String=""
    @State var info_saved = false
    var body: some View {
        ZStack{
            VStack {
            Text("Edit Profile").multilineTextAlignment(.leading).foregroundColor(Color.red)
                .font(.system(size: 35, weight: .bold))
                
                Spacer()
                
                HStack{
                    //this image needs to be imported from firebase
                    Image("maria").resizable().clipShape(Circle())
                        .overlay(Circle().stroke(Color.black, lineWidth: 4))
                        .frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding()
                    
                    VStack{
                        Text("Maria Carrey")
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 25, weight: .bold))
                        Text("@mariacurry")
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 15, weight: .light))
                            .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                            
                    }
                    
                }
                
                VStack {
                Spacer()
                
                TextField("Age", text: $age)
                    .background(Color.red)
                    .cornerRadius(5)
                    .frame(width: 250, height: 0, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                TextField("Gender", text: $gender)
                    .background(Color.red)
                    .cornerRadius(5)
                    .frame(width: 250, height: 0, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
                TextField("Location", text: $location)
                    .background(Color.red)
                    .cornerRadius(5)
                    .frame(width: 250, height: 0, alignment: .center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                    
                }
                
                
                Button(action: {
                   //Save info to firebase
                    print("Hey")
                    info_saved = true
                    }){
                    Text("Save").frame(width: 200, height: 0, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .border(Color.yellow, width:5)
                        .cornerRadius(40)
                }

                

                if (info_saved == true){
                    Text("Information Saved.")
                        .font(.system(size: 20, weight: .semibold, design: .rounded ))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)                }
 
            
            }
            
            
        }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
