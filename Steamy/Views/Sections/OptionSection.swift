//
//  OptionSection.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 7/22/21.
//

import SwiftUI

struct OptionSection: View {
    var body: some View {
        HStack(spacing:0) {
            Button(action: {}) {
                Image("no")
                .resizable()
                .frame(width: 82, height: 78)
            }
            Button(action: {}) {
                Image("Steamy App Design")
                .resizable()
                .frame(width: 82, height: 70)
            }
        }
    }
}

struct OptionSection_Previews: PreviewProvider {
    static var previews: some View {
        OptionSection()
    }
}
