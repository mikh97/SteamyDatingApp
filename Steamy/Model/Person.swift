//
//  Person.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/22/21.
//

import SwiftUI

class Person: ObservableObject {
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    var profileImageUrl: String
    var status: String
    var gender: String?
    var age: String?

    
    @Published var galleryImages: [String]?
    
    // used for card manipulation
    @Published var x: CGFloat = 0.0
    @Published var y: CGFloat = 0.0
    @Published var degree: Double = 0.0
    
    init(uid: String, firstName: String, lastName: String, email: String, profileImageUrl: String, status: String) {
        self.uid = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.status = status
        self.x = 0.0
        self.y = 0.0
        self.degree = 0.0
    }
    
    static func transformPerson(dict: [String: Any]) -> Person? {
        guard let email = dict["email"] as? String,
              let firstName = dict["firstName"] as? String,
              let lastName = dict["lastName"] as? String,
              let profileImageUrl = dict["profileImageUrl"] as? String,
              let status = dict["status"] as? String,
              let uid = dict["uid"] as? String else {
            return nil
        }
        
        let person = Person(uid: uid, firstName: firstName, lastName: lastName, email: email, profileImageUrl: profileImageUrl, status: status)
        
        if let gender = dict["gender"] as? String {
            person.gender = gender
        }
        
        if let age = dict["age"] as? String {
            person.age = age
        }
        
        return person
    }
    
    
    func setGalleryImages(value: [String]) {
        self.galleryImages = value
    }
    
}


extension Person {
    static let example = Person(uid: "qweqweqweqweq", firstName: "FName", lastName: "LName", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/500", status: "my status")
    
    
    static let examples = [
        example,
        Person(uid: "qweqweqweqweq1", firstName: "FName1", lastName: "LName1", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/501", status: "my status1"),
        Person(uid: "qweqweqweqweq2", firstName: "FName2", lastName: "LName2", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/502", status: "my status2"),
        Person(uid: "qweqweqweqweq3", firstName: "FName3", lastName: "LName3", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/503", status: "my status3"),
        Person(uid: "qweqweqweqweq4", firstName: "FName4", lastName: "LName4", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/504", status: "my status4"),
        Person(uid: "qweqweqweqweq5", firstName: "FName5", lastName: "LName5", email: "haha@haha.com", profileImageUrl: "https://picsum.photos/505", status: "my status5")
    ]
    
    
    static let exampleGallery = [
        "https://picsum.photos/300/400",
        "https://picsum.photos/400/501",
        "https://picsum.photos/400/302",
        "https://picsum.photos/400/303"
    ]
}
