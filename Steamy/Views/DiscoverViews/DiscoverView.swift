//
//  DiscoverView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/24/21.
//

import SwiftUI

struct DiscoverView: View {
    
    @EnvironmentObject var userApi: UserApi
    
    @State var showNewMatchView = false
    @State private var isShowPhotoLibrary = false
    @State private var profileImage = UIImage()
    @State private var hasTimeElapsed = false
    
//    @State private var fullscreenMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
                Text("Discover").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
                Spacer()
            }

            Spacer()
            
            if !userApi.cardPeople.isEmpty && !Api.User.isNewUser {
                CardStack(people: userApi.cardPeople, showNewMatchView: $showNewMatchView)
            
            
            Spacer()
            
//            if !fullscreenMode {
                HStack(spacing: 20) {
                    Spacer()
                    
                    CircleButtonView(type: .no) {
                        if let person = userApi.cardPeople.last {
                            userApi.swipe(person: person, direction: .nope) { matchedPerson in
                                //
                            }
                        }
                    }
                    
                    CircleButtonView(type: .heart) {
                        if let person = userApi.cardPeople.last {
                            userApi.swipe(person: person, direction: .like) { matchedPerson in
                                userApi.currentMatchedPersonID = matchedPerson.uid
                                self.showNewMatchView = true
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $showNewMatchView) {
                        NewMatchView(showNewMatchView: self.$showNewMatchView, matchedPersonID: userApi.currentMatchedPersonID)
                    }
                    
                    Spacer()
                    
                }
                .frame(height: 50)
                .padding(.horizontal)
                .padding(.vertical, 25)
//            }
            } else if userApi.isNewUser {
                VStack {
                    Text("Unlock the cards by uploading profile picture.")
                        .font(.system(size: 40, weight: .bold))
                        .padding()
                    
                    Spacer().frame(height: 20)
                    
                    FullWidthTextButton(action: {
                        self.isShowPhotoLibrary = true
                        
                    }, text: "Unlock")
                        .sheet(isPresented: $isShowPhotoLibrary) {
                            ImagePickerWithEditing(sourceType: .photoLibrary, imageType: "profile", selectedImage: self.$profileImage)
                                .onDisappear {
                                    userApi.getUserDetails(uid: Api.User.currentUserId) { user in
                                        if user.profileImageUrl != "" {
                                            userApi.isNewUser = false
                                            userApi.loadCardPeople()
                                        }
                                    }
                                }
                        }
                }
                
                
            } else if userApi.cardPeople.isEmpty && !Api.User.isNewUser {
                if hasTimeElapsed {
                    VStack {
                        Text("Sad. \nRefresh if you still don't have any matches.")
                            .font(.system(size: 40, weight: .bold))
                            .padding()
                        
                        Spacer().frame(height: 20)
                        
                        FullWidthTextButton(action: {
                            userApi.loadCardPeople()
                            
                        }, text: "Refresh")
                    }
                } else {
                    ProgressView()
                        .onAppear {
                            delayView()
                        }
                        .onDisappear {
                            hasTimeElapsed = false
                        }
                }
            } else {
                ProgressView()
            }
            
            Spacer()
        }
        .onAppear {
            
        }
    }
    private func delayView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            hasTimeElapsed = true
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(UserApi())
    }
}
