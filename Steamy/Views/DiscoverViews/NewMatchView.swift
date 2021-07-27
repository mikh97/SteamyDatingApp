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
    
    @State var profileImageUrl = ""
    @State var matchedFirstName = ""
    @State var matchedProfileImageUrl = ""
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("It's a Match!")
                .font(.system(size: 50, weight: .semibold))
                .foregroundColor(Color.red)
                .padding()
            
            Text("You and \(matchedFirstName) have liked each other.")
                .font(.system(size: 18, weight: .medium))
                .padding()
            
            
            HStack(spacing: 20) {
                RoundedImage(url: URL(string: profileImageUrl))
                    .frame(height: 150)
                
                RoundedImage(url: URL(string: matchedProfileImageUrl))
                    .frame(height: 150)
            }
            .padding()
            
            Spacer().frame(height: 50)
            
            
            Button(action: {
                self.showNewMatchView = false
                // navigate to chat view
                
            }, label: {
                Text("Send a Message")
                    .font(Font.system(size: 15, weight: .semibold))
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding([.top, .bottom], 10)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(6)
                    .padding([.top, .bottom], 10)
                    .padding()
            })
            
            FullWidthTextButton(action: {
                self.showNewMatchView = false
            }, text: "Dismiss")
            
            Spacer()
        }
        .onAppear {
            Api.User.getUserInfoSingleEvent(uid: matchedPersonID) { user in
                matchedFirstName = user.firstName
                matchedProfileImageUrl = user.profileImageUrl
            }

            Api.User.getUserInfoSingleEvent(uid: Api.User.currentUserId) { user in
                profileImageUrl = user.profileImageUrl
            }
        }
    }
}

struct NewMatchView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatchView(showNewMatchView: .constant(true), matchedPersonID: Person.example.uid)
//        NewMatchView()
    }
}
