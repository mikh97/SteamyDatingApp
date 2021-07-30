//
//  ChatViewHeader.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import SwiftUI

struct ChatViewHeader: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    let name: String
    let imageURL: URL?
    
    var body: some View {
        ZStack {
            Color(UIColor.systemGray6)
                .edgesIgnoringSafeArea(.top)
                .shadow(radius: 3)
            
            
            HStack {
                Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.red)
                        .font(.system(size: 28, weight: .semibold))
                }
                
                Spacer()
                
                VStack(spacing: 6) {
                    RoundedImage(url: imageURL)
                        .frame(height: 50)
                    
                    Text(name)
                        .font(.system(size: 14))
                }
                .padding(.top, 10)
                
                Spacer()
                
                Button(action: { }) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 20, weight: .bold))
                }
            }
            .padding(.horizontal, 22)
            .padding(.vertical, 10)
            
        }
        .frame(height: 50)
        
    }
}

struct ChatViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatViewHeader(name: Person.example.firstName, imageURL: URL(string: Person.example.profileImageUrl))
            Spacer()
        }
    }
}
