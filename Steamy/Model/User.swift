//
//  User.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/17/21.
//

import Foundation

class User {
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    var profileImageUrl: String
    var status: String
    var gender: String?
    var age: String?
//    var latitude = ""
//    var longitude = ""
    
    init(uid: String, firstName: String, lastName: String, email: String, profileImageUrl: String, status: String) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.status = status
    }
    
    static func transformUser(dict: [String: Any]) -> User? {
        guard let email = dict["email"] as? String,
              let firstName = dict["firstName"] as? String,
              let lastName = dict["lastName"] as? String,
              let profileImageUrl = dict["profileImageUrl"] as? String,
              let status = dict["status"] as? String,
              let uid = dict["uid"] as? String else {
            return nil
        }
        
        let user = User(uid: uid, firstName: firstName, lastName: lastName, email: email, profileImageUrl: profileImageUrl, status: status)

        if let gender = dict["gender"] as? String {
            user.gender = gender
        }
        
        if let age = dict["age"] as? String {
            user.age = age
        }

        return user
    }
    
    func updateData(key: String, value: String) {
        switch key {
        case "firstName": self.firstName = value
        case "lastName": self.lastName = value
        case "email": self.email = value
        case "profileImageUrl": self.profileImageUrl = value
        case "status": self.status = value
        default: break
        }
    }
    
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
}


extension User {
    static let example = User(uid: "qweqweqweqweq", firstName: "FName", lastName: "LName", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/500", status: "my status")
}
