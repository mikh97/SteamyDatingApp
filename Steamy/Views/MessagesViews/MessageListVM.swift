//
//  MessagaListVM.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import Foundation

class MessageListVM: ObservableObject {
    @Published var messagePreviews: [MessagePreview] = []
    
    
    init() {
        loadPreviews()
    }
    
    func loadPreviews() {
        Api.MessagePreview.lastMessages(uid: Api.User.currentUserId) { (preview) in
            if !self.messagePreviews.contains(where: { $0.user.uid == preview.user.uid }) {
                self.messagePreviews.append(preview)
                self.sortedPreviews()
            }
        }
    }
    
    private func sortedPreviews() {
        messagePreviews = messagePreviews.sorted(by: { $0.date > $1.date })
    }
    
}
