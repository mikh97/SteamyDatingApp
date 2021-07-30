//
//  MessagaListVM.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import Foundation

class MessageListVM: ObservableObject {
    var messagePreviews = [MessagePreview]() {
        willSet {
            if visible {
                objectWillChange.send()
            }
        }
    }
    
    @Published var isNewMatchEmpty = false
    
    init() {
        getNewMatch()
    }
    
    var visible = false
    
    func loadPreviews() {
        Api.MessagePreview.lastMessages(uid: Api.User.currentUserId) { (previews) in
            self.messagePreviews = previews
            self.sortedPreviews()
        }
    }
    
    private func sortedPreviews() {
        messagePreviews = messagePreviews.sorted(by: { $0.date > $1.date })
    }
    
    private func getNewMatch() {
        Ref().databaseRoot.child("newMatch").observe(.value) { snapshot in
            if snapshot.hasChild(Api.User.currentUserId) {
                self.isNewMatchEmpty = false
            } else {
                self.isNewMatchEmpty = true
            }
        }
    }
}
