//
//  MatchView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI

// What's with the persistent back button on the top left corner??

struct InnerProfileView: View {
    var body: some View {
        
        
        NavigationView {
            ZStack{
                
                VStack{
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer(minLength: 30).frame(width: 40, height:0, alignment: .center)
                        Text("Profile").multilineTextAlignment(.leading).foregroundColor(Color.red)
                            .font(.system(size: 35, weight: .bold))
                        
                        Spacer()
                    }
                    
                    HStack{
                        //this image needs to be imported from firebase
                        Image("mainGirl").resizable().clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 3))
                            .frame(width: 125, height: 180, alignment: .center)
                            .padding()
                        
                        VStack{
                            Text("Maria Carrey")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 25, weight: .bold))
                            //The @username text should be left align under the user's name
                            Text("@mariacurry")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer(minLength: 30).frame(width: 10, height:0, alignment: .center)
                        
                        NavigationLink(destination: EditProfileView()){
                            Image(systemName: "pencil.circle.fill").resizable().frame(width:30 , height: 30, alignment: .center)
                                .padding()
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                    //Image List
                    
                    Spacer()
                    
                    HStack{
                        
                        //Add a picture
                        NavigationLink(destination: AddProfileImagePopupView()){
                            RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center).foregroundColor(Color(red: 203/255, green: 203/255, blue: 203/255))
                                .overlay(Image(systemName: "camera.circle.fill").resizable().frame(width: 50, height: 50, alignment: .center).foregroundColor(.gray))
                        }
                        
                        
                        //replace images with images from firebase
                        
                        RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center)
                            .overlay(Image("girlThree").resizable().frame(width: 125, height: 175, alignment: .center).cornerRadius(25))
                        
                        RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center)
                            .overlay(Image("girlTwo").resizable().frame(width: 125, height: 175, alignment: .center).cornerRadius(25)
                            )
                    }
                    
                    
                    
                    //About me
                    
                    Spacer(minLength: 30)
                    
                    //About me text need to left align
                    Text("About me").foregroundColor(Color.black)
                        .font(.system(size: 25, weight: .bold))
                        .multilineTextAlignment(.leading)
                    
                    RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 375, height: 125, alignment: /*@START_MENU_TOKEN@*/.center)
                        .foregroundColor(Color(red: 203/255, green: 203/255, blue: 203/255))
                        
                        //the text in the overlay needs to be json parsed from firebase
                        
                        .overlay(Text("Hello my name is Maria Carrey. I am whore from Space Jam. Lebron James ate me out yesterday. HMU. Bitches").fontWeight(.light).foregroundColor(.black).padding(), alignment: .topLeading
                        )
                    
                    Spacer()
                    
                    
                }
                
            }
            .navigationBarHidden(true).navigationTitle("")
        }
        
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        InnerProfileView()
    }
}
