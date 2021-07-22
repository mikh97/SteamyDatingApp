//
//  DiscoverySection.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 7/22/21.
//

import SwiftUI

struct DiscoverySection: View {
    var body: some View {
        HStack {
            Spacer(minLength: 30).frame(width: 20, height:0, alignment: .center)
            Text("Discover").multilineTextAlignment(.leading).foregroundColor(Color.red).font(.system(size: 35, weight: .bold))
            Spacer()
        }
    }
}

struct DiscoverySection_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverySection()
    }
}
