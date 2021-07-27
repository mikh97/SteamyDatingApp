//
//  MessageView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import SwiftUI

struct MessageView: View {
    
    var message: Message
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            if message.fromCurrentUser {
                Spacer()
            }
            
            Text(message.text)
                .padding(15)
                .foregroundColor(message.fromCurrentUser ? .white : (colorScheme == .dark ? .white : .black))
                .background(message.fromCurrentUser ? Color.red : (colorScheme == .dark ? Color.gray : Color.gray.opacity(0.25)))
                .cornerRadius(25)
            
            if !message.fromCurrentUser {
                Spacer()
            }
        }
        .padding()
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message.exampleReceived)
    }
}
