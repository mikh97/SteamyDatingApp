//
//  CardImageScroller.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/22/21.
//

import SwiftUI
import KingfisherSwiftUI

struct CardImageScroller: View {
    
    @ObservedObject var person: Person
    
    @State private var imageIndex = 0
    
    @Binding var fullscreenMode: Bool
    
    func updateImageIndex(addition: Bool) {
        let newIndex: Int
        
        if addition {
            newIndex = imageIndex + 1
        } else {
            newIndex = imageIndex - 1
        }
        
        imageIndex = min(max(0, newIndex), (person.galleryImages == nil ? 0 : person.galleryImages!.count) - 1)
    }
    
    let screenCutoff = (UIScreen.main.bounds.width / 2) * 0.4
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                ZStack {
                    KFImage(URL(string: person.galleryImages?[imageIndex] ?? ""))
                        .placeholder {
                            ProgressView()
                        }
                        .resizable()
//                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                    
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.25)]), startPoint: .top, endPoint: .bottom)
                    
                    VStack {
                        HStack {
                                Text("NOPE")
                                    .font(.system(size: 50))
                                    .foregroundColor(Color.red)
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.red, lineWidth: 5)
                                    )
                                    .rotationEffect(.degrees(-25))
                                .opacity(Double(person.x / screenCutoff) - 1)
                                

                            Spacer()
                            Text("LIKE")
                                .font(.system(size: 50))
                                .foregroundColor(Color.green)
                                .padding()
                                .overlay(RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.green, lineWidth: 5)
                                )
                                .rotationEffect(.degrees(25))
                                .opacity(Double(person.x / screenCutoff * -1) - 1)
                        }
                        .padding()
                        .padding(.top, 45)

                        Spacer()
                        
                    }
                    
                    HStack {
                        Rectangle()
                            .onTapGesture {
                                updateImageIndex(addition: false)
                            }
                        Rectangle()
                            .onTapGesture {
                                updateImageIndex(addition: true)
                            }
                    }
                    .foregroundColor(Color.white.opacity(0.001))
                }
                
                VStack {
                    HStack {
                        if person.galleryImages != nil && person.galleryImages!.count > 1 {
                            ForEach(0..<(person.galleryImages == nil ? 0 : person.galleryImages!.count)) { imageIndex in
                                RoundedRectangle(cornerRadius: 20)
                                    .frame(height: 4)
                                    .foregroundColor(self.imageIndex == imageIndex ? Color.white : Color.gray.opacity(0.5))
                            }
                        }
                        
                    }
                    .padding(.top, 6)
                    .padding(.horizontal, fullscreenMode ? 0 : 12)
                    
                    Spacer()
                    
                    if !fullscreenMode {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(person.firstName + " " + person.lastName)
                                        .font(.system(size: 32, weight: .heavy))
                                    
                                    Text(String(person.age ?? ""))
                                        .font(.system(size: 28, weight: .light))
                                }
                                
                                Text(person.status)
                                    .font(.system(size: 18, weight: .medium))
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            Button(action: { fullscreenMode = true }) {
                                Image(systemName: "info.circle.fill")
                                    .font(.system(size: 26, weight: .medium))
                                
                            }
                        }
                        .padding(16)
                    }
                    
                }
                .foregroundColor(Color.white)
            }
            .cornerRadius(6)
            .shadow(radius: 5)
        }
        
    }
}

struct CardImageScroller_Previews: PreviewProvider {
    static var previews: some View {
        CardImageScroller(person: Person.example, fullscreenMode: .constant(false))
    }
}
