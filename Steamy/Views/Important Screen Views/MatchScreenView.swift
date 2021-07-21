//
//  MatchScreenView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI

struct MatchScreenView: View {
    var body: some View {
        VStack {
            // Title Stack
            HStack{
                Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
                Text("Discover").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
                Spacer()
            }
            
            // Card
            ZStack {
                
                RoundedRectangle(cornerRadius: 100, style: .continuous)
                    .fill(Color.gray)
                    .frame(width: 375, height: 375, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Image("guyOne").resizable().clipShape(RoundedRectangle(cornerRadius: 100))
                .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.black, lineWidth: 0))
                .frame(width: 275, height: 275, alignment: .center)
                .padding()
            }
            
            HStack {
                Button(action: {}) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.8))
                        .frame(width: 32, height: 32)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.8))
                        .frame(width: 32, height: 32)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                
                Button(action: {}) {
                    Image(systemName: "heart")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.8))
                        .frame(width: 32, height: 32)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 6)
                }
                
            }
            
            
        }
    }
}

struct MatchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MatchScreenView()
    }
}


