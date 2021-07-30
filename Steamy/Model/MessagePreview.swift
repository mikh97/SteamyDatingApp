//
//  MessagePreview.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/24/21.
//

import Foundation

class MessagePreview {
    var date: Double
    var text: String
    var user: User
    var read = false
    var channel: String
    
    init(date: Double, text: String, user: User, read: Bool, channel: String) {
        self.date = date
        self.text = text
        self.user = user
        self.read = read
        self.channel = channel
    }
    
    static func transformMessagePreview(dict: [String: Any], channel: String, user: User) -> MessagePreview? {
        guard let date = dict["date"] as? Double,
            let text = dict["text"] as? String,
            let read = dict["read"] as? Bool else {
                return nil
        }
        let preview = MessagePreview(date: date, text: text, user: user, read: read, channel: channel)
        return preview
    }
    
    func updateData(key: String, value: Any) {
        switch key {
        case "text": self.text = value as! String
        case "date": self.date = value as! Double
        default: break
        }
    }
    
}


//extension MessagePreview: Equatable {
//    static func == (lhs: MessagePreview, rhs: MessagePreview) -> Bool {
//        lhs.date == rhs.date && lhs.user.uid == rhs.user.uid && lhs.channel == rhs.channel
//    }
//}

extension MessagePreview: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}

extension MessagePreview: Equatable {
    public static func ==(lhs: MessagePreview, rhs: MessagePreview) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension MessagePreview {
    static let example = MessagePreview(date: 1627066462.9037929, text: "example text", user: User.example, read: true, channel: "channelID")
    
    static let examples: [MessagePreview] = [
        MessagePreview(date: 1627066462.9037929, text: "example text", user: User.example, read: true, channel: "channelID"),
        MessagePreview(date: 1627066462.9037930, text: "example text1", user: User.example1, read: true, channel: "channelID")
    ]
}
