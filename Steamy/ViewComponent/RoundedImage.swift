//
//  RoundedImage.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/15/21.
//

import SwiftUI
import KingfisherSwiftUI

struct RoundedImage: View {
    
    var url: URL?
    
    var body: some View {

        KFImage(url == nil ? URL(string: "https://picsum.photos/400") : url)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())

    }
}

struct RoundedImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImage(url: URL(string: "https://picsum.photos/400"))
    }
}
