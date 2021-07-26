//
//  HomeView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/24/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var userApi: UserApi
    
//    @State private var fullscreenMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
                Text("Discover").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
                Spacer()
            }

            Spacer()
            
            CardStack(people: userApi.cardPeople)
            
            Spacer()
            
//            if !fullscreenMode {
                HStack(spacing: 20) {
                    Spacer()
                    
                    CircleButtonView(type: .no) {
                        if let person = userApi.cardPeople.last {
                            userApi.swipe(person, .nope)
                        }
                    }
                    
                    CircleButtonView(type: .heart) {
                        if let person = userApi.cardPeople.last {
                            userApi.swipe(person, .like)
                        }
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserApi())
    }
}
