//
//  MatchView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI
import ProgressHUD
import FirebaseDatabase
import FirebaseAuth

// What's with the persistent back button on the top left corner??

struct InnerProfileView: View {
    
    @EnvironmentObject var user: UserApi
    @State var showSheetView = false
    @State private var isShowPhotoLibrary = false
    @State var profileImage = UIImage()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var profileImageUrl = ""
    @State var status = ""
    
    var body: some View {
        
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                ZStack{
                    
                    VStack{
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer(minLength: 30).frame(width: 40, height:0, alignment: .center)
                            Text("Profile").multilineTextAlignment(.leading).foregroundColor(Color.red)
                                .font(.system(size: 35, weight: .bold))
                            
                            Spacer()
                        }
                        
                        VStack{
                            //this image needs to be imported from firebase
                            ZStack(alignment: .topTrailing) {
                                //                                Image(uiImage: self.profileImage)
                                //                                    .resizable()
                                //                                    .clipShape(Circle())
                                //                                    .overlay(Circle().stroke(Color.black, lineWidth: 3))
                                //                                    .frame(width: 125, height: 180, alignment: .center)
                                //                                    .padding()
                                //                                RoundedImage(url: URL(string: "https://picsum.photos/400"))
                                
                                
                                RoundedImage(url: URL(string: profileImageUrl))
                                    .frame(height: 200)
                                    
                                Button(action: {
                                    self.isShowPhotoLibrary = true
                                    
                                }) {
                                    Image(systemName: "camera")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(Color.gray.opacity(0.8))
                                        .frame(width: 32, height: 32)
                                        .background(Color.white)
                                        .clipShape(Circle())
                                        .shadow(radius: 6)
                                }
                                .padding(.vertical, 10)
                                .offset(x: -10)
                                .sheet(isPresented: $isShowPhotoLibrary) {
                                    ImagePicker(sourceType: .photoLibrary, imageType: "profile", selectedImage: self.$profileImage)
                                }
                            }
                            
                            Spacer().frame(height: 18)
                            
                            Text(firstName + " " + lastName)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 25, weight: .bold))
                            
                            //                            Spacer().frame(height: 8)
                            
                            //                            Text("@mariacurry")
                            //                                .multilineTextAlignment(.leading)
                            //                                .font(.system(size: 15, weight: .light))
                            //                                .foregroundColor(.gray)
                            
                            Spacer(minLength: 30).frame(width: 10, height:0, alignment: .center)
                            
                            FullWidthTextButton(action: {
                                self.showSheetView.toggle()
                            }, text: "Edit Profile")
                            .fullScreenCover(isPresented: $showSheetView) {
                                EditProfileView(showSheetView: self.$showSheetView)
                            }
                            
                            
                        }
                        
                        //Image List
                        
                        Spacer()
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                
                                Button(action: {
                                    self.isShowPhotoLibrary = true
                                }) {
                                    RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center).foregroundColor(Color(red: 203/255, green: 203/255, blue: 203/255))
                                        .overlay(Image(systemName: "camera.circle.fill").resizable().frame(width: 50, height: 50, alignment: .center).foregroundColor(.gray))
                                }
                                .sheet(isPresented: $isShowPhotoLibrary) {
                                    ImagePicker(sourceType: .photoLibrary, imageType: "gallery",  selectedImage: self.$profileImage)
                                }
                                
                                // loop the images from firebase
                                
                                RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center)
                                    .overlay(Image("girlThree").resizable().frame(width: 125, height: 175, alignment: .center).cornerRadius(25))
                                
                                RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center)
                                    .overlay(Image("girlTwo").resizable().frame(width: 125, height: 175, alignment: .center).cornerRadius(25))
                                
                                RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center)
                                    .overlay(Image("girlTwo").resizable().frame(width: 125, height: 175, alignment: .center).cornerRadius(25))
                                
                            }
                            
                        }
                        .padding()
                        
                        //About me
                        
                        Spacer(minLength: 30)
                        
                        //About me text need to left align
                        Text("About me")
                            .font(.system(size: 25, weight: .bold))
                            .multilineTextAlignment(.leading)
                        
                        NavigationLink(destination: StatusView()) {
                            RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 375, height: 125, alignment: /*@START_MENU_TOKEN@*/.center)
                                .foregroundColor(Color(red: 203/255, green: 203/255, blue: 203/255))
                                
                                //the text in the overlay needs to be json parsed from firebase
                                
                                .overlay(Text(status).fontWeight(.light).foregroundColor(.black).padding(), alignment: .topLeading)
                        }
                        
                        
                        Spacer()
                        
                        FullWidthTextButton(action: {
                            user.signOut { errorMessage in
                                ProgressHUD.showError(errorMessage)
                            }
                        }, text: "Sign Out")
                        
                    }
                    
                }
                
            }
            .padding(.top, 1)
            .navigationBarHidden(true)
            .navigationTitle("")
            .onAppear {
                Api.User.getUserDetails(uid: Api.User.currentUserId) { (user) in
                    firstName = user.firstName
                    lastName = user.lastName
                    profileImageUrl = user.profileImageUrl == "" ? "https://picsum.photos/400" : user.profileImageUrl
                    status = user.status
                }
            }
            
        }
        
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        InnerProfileView()
    }
}


struct StatusView: View {
    @State private var statusText: String = ""
    @State private var wordCount: Int = 0
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TextEditor(text: $statusText)
                .onAppear {
                    Api.User.getUserDetails(uid: Api.User.currentUserId) { (user) in
                        statusText = user.status
                    }
                }
                .lineSpacing(20)
                .autocapitalization(.sentences)
                .disableAutocorrection(true)
                .padding()
                .navigationBarTitle("Status", displayMode: .inline)
                .navigationBarItems(trailing: NavigationLink(destination: InnerProfileView()) {
                    Button(action: {
                        // save data to firebase
                        ProgressHUD.show()
                        let dict: Dictionary<String, Any> = [
                            "status": statusText
                        ]
                        Api.User.saveUserProfile(dict: dict) {
                            print("status update success")
                        } onError: { errorMessage in
                            ProgressHUD.showError(errorMessage)
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            ProgressHUD.dismiss()
                            self.presentationMode.wrappedValue.dismiss()
                            print("dismiss status view - done")
                        }
                        
                        
                    }) {
                        Text("Done").bold()
                    }
                }
                )
                .onChange(of: statusText) { value in
                    let words = statusText.split { $0 == " " || $0.isNewline }
                    self.wordCount = words.count
                    
                }
            
            Text("\(wordCount)")
                .foregroundColor(.secondary)
                .padding(.trailing)
                .padding(.bottom)
        }
    }
}
