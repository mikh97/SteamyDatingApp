//
//  MessageRowView.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import SwiftUI
import KingfisherSwiftUI

struct MessageRowView: View {
    
    var preview: MessagePreview
    
    var body: some View {
        HStack {
            RoundedImage(url: URL(string: preview.user.profileImageUrl))
                .frame(height: 90)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(preview.user.firstName + " " + preview.user.lastName)
                    .font(.system(size: 21, weight: .semibold))
                
                Text(preview.text)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
        }
        
    }
}

struct MessageRowView_Previews: PreviewProvider {
    static var previews: some View {
        MessageRowView(preview: MessagePreview.example)
    }
}
