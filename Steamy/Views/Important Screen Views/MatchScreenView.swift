//
//  MatchScreenView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/4/21.
//

import SwiftUI

struct MatchScreenView: View {
    var body: some View {
        VStack {
            NavigationSection()
            CardSection()
            OptionSection()
        }
    }
}

struct MatchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MatchScreenView()
        }
    }
}
