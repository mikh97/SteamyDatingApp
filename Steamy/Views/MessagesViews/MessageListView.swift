//
//  MessageListView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI

struct MessageListView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
                    Text("Messages").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
                    Spacer()
                }
                Spacer()
            }
        }
        .padding(.top, 1)
    }
}

struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        MessageListView()
    }
}
