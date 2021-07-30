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
                .padding(12)
                .foregroundColor(message.fromCurrentUser ? .white : (colorScheme == .dark ? .white : .black))
                .background(message.fromCurrentUser ? Color.red : Color(.systemGray6))
                .cornerRadius(30)
            
            if !message.fromCurrentUser {
                Spacer()
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message.exampleReceived)
    }
}
