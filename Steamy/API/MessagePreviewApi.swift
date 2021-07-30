//
//  MessagePreviewApi.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/29/21.
//

import Foundation
import Firebase

typealias MessagePreviewCompletion = ([MessagePreview]) -> Void

class MessagePreviewApi {
    
    func lastMessages(uid: String, onSuccess: @escaping(MessagePreviewCompletion) ) {
        
        let ref = Database.database().reference().child(REF_MESSAGE_PREVIEW).child(uid)
        ref.observe(.value) { (snapshot) in
            var previews = [MessagePreview]()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                if let dict = child.value as? Dictionary<String, Any> {
                    guard let partnerId = dict["to"] as? String else {
                        return
                    }
                    
                    let uid = (partnerId == Api.User.currentUserId) ? (dict["from"] as! String) : partnerId
                    let channelId = Message.hash(forMembers: [uid, partnerId])
                    
                    Api.User.getUserDetails(uid: uid, onSuccess: { (user) in
                        
                        if let preview = MessagePreview.transformMessagePreview(dict: dict, channel: channelId, user: user) {
                            previews.append(preview)
                        }
                        onSuccess(previews)
                    })
                }
            }
        }
  
    }
}
