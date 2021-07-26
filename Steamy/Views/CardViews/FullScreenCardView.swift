//
//  FullScreenCardView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/22/21.
//

import SwiftUI
import KingfisherSwiftUI

struct FullScreenCardView: View {
    
    @ObservedObject var person: Person
    
    @Binding var fullscreenMode: Bool
    
    let screen = UIScreen.main.bounds
    
    var nameSpace: Namespace.ID
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var userApi: UserApi
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            if colorScheme == .dark {
                Color.black.edgesIgnoringSafeArea(.all)
            } else {
                Color.white.edgesIgnoringSafeArea(.all)
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    CardImageScroller(person: person, fullscreenMode: $fullscreenMode)
                        .frame(width: screen.width, height: screen.height * 0.6)
                        .matchedGeometryEffect(id: "image\(person.uid)", in: nameSpace)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(person.firstName + " " + person.lastName)
                                    .font(.system(size: 32, weight: .heavy))
                                
                                Text(String(person.age ?? ""))
                                    .font(.system(size: 28, weight: .light))
                                
                                Spacer()
                            }
                            .opacity(0.75)
                            
                            Text("")
                        }
                        .padding([.horizontal, .top], 16)
                        
                        Button(action: {
                            fullscreenMode = false
                        }) {
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.system(size: 42))
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 16)
                        .offset(y: -40)
                    }
                    
                    Spacer().frame(height: 26)
                    
                    HStack {
                        Text(person.status)
                            .font(.system(size: 18, weight: .medium))
                            .lineLimit(20)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .opacity(0.75)
                            .padding(.horizontal, 16)
                        
                        Spacer()
                    }
                    
                    Spacer().frame(height: 250)
                }
            }
            
            HStack(spacing: 20) {
                Spacer()
                
                CircleButtonView(type: .no, action: {
                    fullscreenMode = false
                    userApi.swipe(person, .nope)
                })
                    .frame(height: 50)
                
                CircleButtonView(type: .heart, action: {
                    fullscreenMode = false
                    userApi.swipe(person, .like)
                })
                    .frame(height: 50)
                
                Spacer()
                
            }
            .padding(.top, 25)
//            .padding(.bottom, 45)
            .padding(.bottom, 100)
            .edgesIgnoringSafeArea(.bottom)
            .background(LinearGradient(gradient: Gradient(colors: [colorScheme == .dark ? Color.black.opacity(0.5) : Color.white.opacity(0.5), colorScheme == .dark ? Color.black : Color.white]), startPoint: .top, endPoint: .bottom))
            .padding(.top, 40)
        }
        .edgesIgnoringSafeArea(.bottom)
        .padding(.top, 40)
//        .padding(.top, 100)
        
    }
}

struct FullScreenCardView_Previews: PreviewProvider {
    @Namespace static var placeholder
    static var previews: some View {
        FullScreenCardView(person: Person.example, fullscreenMode: .constant(true), nameSpace: placeholder)
    }
}
