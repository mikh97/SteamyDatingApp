//
//  CardModel.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 7/12/21.
//

import UIKit

// DATA
struct Card: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let bio: String
    
    // card x position
    var x: CGFloat = 0.0
    
    // card y position
    var y: CGFloat = 0.0
    
    // card rotation angle
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
        //test cards for now should be a real user from the firebase database
        Card(name: "Panda", imageName: "guyOne", age: 23, bio: "What's good baby!!"),
        Card(name: "Yuji", imageName: "guyTwo", age: 21, bio: "Hasta la vista baby!!"),
        Card(name: "Gojo", imageName: "guyThree", age: 25, bio: "Let's procreate"),
        Card(name: "Yuta", imageName: "guyFour", age: 24, bio: "Shut cho ass up"),
        Card(name: "Sukuna", imageName: "guyFive", age: 18, bio: "freak irl"),
        Card(name: "Fushiguro", imageName: "guySix", age: 19, bio: "Ayo whats gooddd")
        ]
    }
}
