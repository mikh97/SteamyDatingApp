//
//  FullWidthTextButton.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/15/21.
//

import SwiftUI

struct FullWidthTextButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var action: () -> Void
    var text: String
    
    var body: some View {
        
        Button(action: {
            action()
            
        }, label: {
            Text(text)
                .font(Font.system(size: 15, weight: .semibold))
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 10)
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.gray.opacity(0.75), lineWidth: 1)
                )
                .padding([.top, .bottom], 10)
                .padding()
        })
        
    }
}


struct FullWidthTextButton_Previews: PreviewProvider {
    static var previews: some View {
        FullWidthTextButton(action: {}, text: "Preview")
    }
}
