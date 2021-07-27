//
//  ProfileView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI
import ProgressHUD
import FirebaseDatabase
import FirebaseAuth
import KingfisherSwiftUI

// What's with the persistent back button on the top left corner??

struct ProfileView: View {
    
    @EnvironmentObject var user: UserApi
    @State var showSheetView = false
    @State private var isShowPhotoLibrary = false
    @State private var isShowPhotoLibraryGallery = false
    @State var profileImage = UIImage()
    
    @State var firstName = ""
    @State var lastName = ""
    @State var profileImageUrl = ""
    @State var status = ""
    
    @State var galleryDict = Dictionary<String, String>()
    @State var galleryUrlArray = [String]()
    @State var isGalleryEmpty = false
    @State var keys = [String]()
    @State var values = [String]()
    
    var body: some View {
        
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                ZStack{
                    
                    VStack{
                        
                        Spacer()
                        
                        HStack {
                            
                            Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
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
                                    ImagePickerWithEditing(sourceType: .photoLibrary, imageType: "profile", selectedImage: self.$profileImage)
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
                                    self.isShowPhotoLibraryGallery = true
                                }) {
                                    RoundedRectangle(cornerRadius: 25.0/*@END_MENU_TOKEN@*/).frame(width: 125, height: 175, alignment: /*@START_MENU_TOKEN@*/.center).foregroundColor(Color(red: 203/255, green: 203/255, blue: 203/255))
                                        .overlay(Image(systemName: "plus.circle.fill").resizable().frame(width: 50, height: 50, alignment: .center).foregroundColor(.gray))
                                }
                                .sheet(isPresented: $isShowPhotoLibraryGallery) {
                                    ImagePicker(sourceType: .photoLibrary, imageType: "gallery",  selectedImage: self.$profileImage)
                                }
                                
                                if isGalleryEmpty {
                                    Text("Add images to the gallery.")
                                        .padding()
                                        .font(Font.system(size: 15, weight: .semibold))
                                        .foregroundColor(Color(UIColor.white))
                                        .padding([.top, .bottom], 10)
                                        .frame(height: 175)
                                        .cornerRadius(25)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                        )
                                        .background(Color.red)
                                        .cornerRadius(25)
                                        .frame(maxWidth: .infinity)
                                        
                                } else {
                                    ForEach(galleryDict.sorted(by: >), id: \.key) { key, url in
                                        NavigationLink(destination: GalleryPhotoView(url: url)) {
                                            KFImage(URL(string: url))
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                                .frame(width: 125, height: 175, alignment: .center)
                                                .cornerRadius(25)
                                        }
                                    }
                                }
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
                    profileImageUrl = user.profileImageUrl 
                    status = user.status
                }
                Api.User.getGallery(uid: Api.User.currentUserId) { dict in
                    galleryDict = dict
                    keys = dict.map{$0.key}
                    values = dict.map {$0.value}
                    isGalleryEmpty = false
                } onEmpty: { isEmpty in
                    isGalleryEmpty = isEmpty
                }



            }
            
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


struct StatusView: View {
    @State private var wordCount: Int = 0
    
    @ObservedObject var textFieldManager = TextFieldManager()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TextEditor(text: $textFieldManager.userInput)
                .onAppear {
                    Api.User.getUserDetails(uid: Api.User.currentUserId) { (user) in
                        textFieldManager.userInput = user.status
                    }
                }
                .keyboardType(.twitter)
                .onChange(of: textFieldManager.userInput) { value in
                    self.wordCount = textFieldManager.userInput.count
                    
                }
                .autocapitalization(.sentences)
                .disableAutocorrection(true)
                .padding()
                .navigationBarTitle("Status", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        // save data to firebase
                        ProgressHUD.show()
                        let dict: Dictionary<String, Any> = [
                            "status": textFieldManager.userInput
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
                
                )
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                
            
            Text("\(wordCount)/150")
                .foregroundColor(.secondary)
                .padding(.trailing)
                .padding(.bottom)
        }
    }
}

class TextFieldManager: ObservableObject {
    
    let characterLimit = 150
    
    @Published var userInput = "" {
            didSet {
                if userInput.count > characterLimit {
                    userInput = String(userInput.prefix(characterLimit))
                }
            }
        }
    
}

struct GalleryPhotoView: View {
    
    var url: String
    
    @State var showActionSheet = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func deleteImage() {
        StorageService.deletingImageFromStorage(uid: Api.User.currentUserId, url: url)
    }
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Button(action: {
                    showActionSheet.toggle()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(Color(UIColor.red))
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(
                                title: Text("Delete Photo?"),
                                message: Text("You can't undo this action."),
                                buttons:[
                                    .destructive(Text("Delete"),
                                                 action: {
                                                    deleteImage()
                                                    self.presentationMode.wrappedValue.dismiss()
                                                 }),
                                    .cancel()
                                ]
                            )
                        }
                }
            }))
    }
}
