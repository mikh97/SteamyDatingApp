//
//  MessageApi.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/28/21.
//

import Foundation
import Combine
import UIKit
import Firebase

class MessageApi {
    
    public func sendMessage(from: String, to: String, value: Dictionary<String, Any>, onError: @escaping() -> Void) {
        let channelId = Message.hash(forMembers: [from, to])

        let ref = Database.database().reference().child("feedMessages").child(channelId)
        ref.childByAutoId().updateChildValues(value) { error, ref in
            if error == nil {
                var dict = value
                if let text = dict["text"] as? String, text.isEmpty {
                    dict["imageUrl"] = nil
                    dict["height"] = nil
                    dict["width"] = nil
                }
                
                let refFromMessagePreview = Database.database().reference().child(REF_MESSAGE_PREVIEW).child(from).child(channelId)
                refFromMessagePreview.updateChildValues(dict)
                let refToMessagePreview = Database.database().reference().child(REF_MESSAGE_PREVIEW).child(to).child(channelId)
                refToMessagePreview.updateChildValues(dict)
            
            } else {
                onError()
            }
        }
    }
    
    public func receiveMessage(from: String, to: String, onSuccess: @escaping(Message) -> Void) {
        let channelId = Message.hash(forMembers: [from, to])
        let ref = Database.database().reference().child("feedMessages").child(channelId)
        ref.queryOrderedByKey()
            .observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key) {
                    onSuccess(message)
                }
            }
        }
    }
}
