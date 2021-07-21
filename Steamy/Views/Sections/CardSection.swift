//
//  CardSection.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 7/22/21.
//

import SwiftUI

struct CardSection: View {
    var body: some View {
        ZStack{
            ForEach(Card.data.reversed()) { card in
                CView(card: card)
            }
        }
        .padding(8)
        .zIndex(1.0)
    }
}

struct CardSection_Previews: PreviewProvider {
    static var previews: some View {
        CardSection()
    }
}
