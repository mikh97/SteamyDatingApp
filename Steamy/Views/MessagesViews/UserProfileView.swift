//
//  UserProfileView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/30/21.
//

import SwiftUI
import KingfisherSwiftUI

struct UserProfileView: View {
    
    @Binding var showSheetView: Bool
    
    @State var galleryDict = Dictionary<String, String>()
    @State var isGalleryEmpty = false
    @State var keys = [String]()
    @State var values = [String]()
    
    let user: User
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    RoundedImage(url: URL(string: user.profileImageUrl))
                        .frame(height: 200)
                        .padding(.top)
                    
                    HStack {
                        Text(user.firstName + " " + user.lastName)
                            .font(.system(size: 32, weight: .heavy))
                        
                        Text(String(user.age ?? ""))
                            .font(.system(size: 28, weight: .light))
                    }
                    .padding()
                    
                    if user.gender != nil {
                        Text(user.gender!)
                            .font(.system(size: 18, weight: .light))
//                            .padding()
                    }
                    
                    Text(user.status)
                        .font(.system(size: 18, weight: .medium))
                        .lineLimit(.none)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    
                    Spacer()
                    
                    if !isGalleryEmpty {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
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
                        .padding()
                        
                    } else {
                        Text("Sorry. \(user.firstName) does not upload any images to gallery.")
                            .padding()
                    }
                    
                    Spacer()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing: Button {
                showSheetView = false
            } label: {
                Text("Dismiss")
            })
        }
        .onAppear {
            Api.User.getGallery(uid: user.uid) { dict in
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

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(showSheetView: .constant(true), user: User.example)
    }
}
