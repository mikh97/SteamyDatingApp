//
//  NewMatchView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/27/21.
//

import SwiftUI

struct NewMatchView: View {
    
    @Binding var showNewMatchView: Bool
    
    var matchedPersonID: String
    
    var body: some View {
        Spacer()
        
        Text(matchedPersonID)
        
        Spacer()
        
        FullWidthTextButton(action: {
            self.showNewMatchView = false
        }, text: "Send a Message")
        
        FullWidthTextButton(action: {
            self.showNewMatchView = false
        }, text: "Dismiss")
        
        Spacer()
    }
}

struct NewMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchView(showNewMatchView: .constant(true), matchedPersonID: Person.example.uid)
    }
}
