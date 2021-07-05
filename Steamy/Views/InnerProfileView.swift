//
//  MatchView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI


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
                        Image("maria").resizable().clipShape(Circle())
                            .overlay(Circle().stroke(Color.black, lineWidth: 4))
                            .frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding()
                        
                        VStack{
                            Text("Maria Carrey")
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 25, weight: .bold))
                            Text("@mariacurry")
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15, weight: .light))
                                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                
                        }
                        
                        Spacer(minLength: 30).frame(width: 10, height:0, alignment: .center)
                        
                        NavigationLink(destination: EditProfileView()){
                            Image(systemName: "pencil.circle.fill").resizable().frame(width:30 , height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .padding()
                                .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
                        }
                        
                    }
                    
                    //Image List
                    
                    Spacer()
                    
                    HStack{
                        
                        //Add a picture
                        NavigationLink(destination: AddProfileImagePopupView()){
                            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color(red: 203/255, green: 203/255, blue: 203/255))
                                .overlay(Image(systemName: "camera.circle.fill").resizable().frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.gray))
                        }
                        
                        
                        //replace images with images from firebase
                        
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(Image("image1").resizable().frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(25))
                        
                        RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .overlay(Image("image2").resizable().frame(width: 125, height: 150, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(25)
                                                                                                                                            )
                    }
                    
                    
            
                    //About me
                    
                    
                    Spacer()
                    
                    Text("About me").foregroundColor(Color.red)
                        .font(.system(size: 30, weight: .bold))
                        .multilineTextAlignment(.leading)
                    
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/).frame(width: 375, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
