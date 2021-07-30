//
//  ChatViewVM.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/29/21.
//

import Foundation
import Combine
import UIKit
import Firebase

class ChatViewVM: ObservableObject {
    
    @Published var messages: [Message] = []
    @Published var keyboardIsShowing: Bool = false
    
    var cancellable: AnyCancellable? = nil
    
    private var user: User
    
    init(user: User) {
        self.user = user
        loadMessages()
        setupPublisher()
    }
    
    public func sendMessage(dict: Dictionary<String, Any>, onError: @escaping() -> Void) {
        
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = user.uid
        value["date"] = date
        value["read"] = true
        Api.Message.sendMessage(from: Api.User.currentUserId, to: user.uid, value: value) {
            onError()
        }
    }
    
    func loadMessages() {
        Api.Message.receiveMessage(from: Api.User.currentUserId, to: user.uid) { (message) in
            self.messages.append(message)
            self.sortMessages()
        }
    }
    
    func sortMessages() {
        messages = messages.sorted(by: { $0.date < $1.date })
    }
    
    private let keyboardWillShow = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map({ _ in true })
    
    private let keyboardWillHide = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map({ _ in false })
    
    private func setupPublisher() {
        cancellable = Publishers.Merge(keyboardWillShow, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \.keyboardIsShowing, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    
}
