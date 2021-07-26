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

        KFImage(url?.absoluteString == "" ? URL(string: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png") : url)
            .placeholder({
                Image("blankProfileImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            })
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
