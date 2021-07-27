//
//  DiscoverView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/24/21.
//

import SwiftUI

struct DiscoverView: View {
    
    @EnvironmentObject var userApi: UserApi
    
    @State var showNewMatchView = false
    
//    @State private var fullscreenMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
                Text("Discover").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
                Spacer()
            }

            Spacer()
            
            CardStack(people: userApi.cardPeople, showNewMatchView: $showNewMatchView)
            
            Spacer()
            
//            if !fullscreenMode {
                HStack(spacing: 20) {
                    Spacer()
                    
                    CircleButtonView(type: .no) {
                        if let person = userApi.cardPeople.last {
                            userApi.swipe(person: person, direction: .nope) { matchedPerson in
                                //
                            }
                        }
                    }
                    
                    CircleButtonView(type: .heart) {
                        if let person = userApi.cardPeople.last {
                            userApi.swipe(person: person, direction: .like) { matchedPerson in
                                userApi.currentMatchedPersonID = matchedPerson.uid
                                self.showNewMatchView = true
                            }
                        }
                    }
                    .fullScreenCover(isPresented: $showNewMatchView) {
                        NewMatchView(showNewMatchView: self.$showNewMatchView, matchedPersonID: userApi.currentMatchedPersonID)
                    }
                    
                    Spacer()
                    
                }
                .frame(height: 50)
                .padding(.horizontal)
                .padding(.vertical, 25)
//            }
            
            Spacer()
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
            .environmentObject(UserApi())
    }
}
