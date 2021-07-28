//
//  MessagePreviewApi.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/29/21.
//

import Foundation
import Firebase

typealias MessagePreviewCompletion = (MessagePreview) -> Void

class MessagePreviewApi {
    
    func lastMessages(uid: String, onSuccess: @escaping(MessagePreviewCompletion) ) {
        
        let ref = Database.database().reference().child(REF_MESSAGE_PREVIEW).child(uid)
        ref.queryOrdered(byChild: "date")
            .queryLimited(toLast: 8)
            .observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                
                guard let partnerId = dict["to"] as? String else {
                    return
                }
                
        let uid = (partnerId == Api.User.currentUserId) ? (dict["from"] as! String) : partnerId
                let channelId = Message.hash(forMembers: [uid, partnerId])
                
                Api.User.getUserDetails(uid: uid, onSuccess: { (user) in
                    
                    if let preview = MessagePreview.transformMessagePreview(dict: dict, channel: channelId, user: user) {
                        
                        onSuccess(preview)
                    }
                })
            }
        }
  
    }
}
