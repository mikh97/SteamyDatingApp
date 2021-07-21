//
//  Card.swift
//  Steamy
//
//  Created by Mikhail Sumawan on 7/22/21.
//

import UIKit

//Card Data
struct Card: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let age: Int
    let bio: String
    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0

    static var data: [Card] {
        [
            Card(name: "Bonito", imageName: "mainGirl", age: 23, bio: "Soy mexico"),
            Card(name: "Giannis", imageName: "girlTwo", age: 21, bio: "Soy Peru"),
            Card(name: "Trey", imageName: "girlThree", age: 54, bio: "Soy Colombia. mucho gusto"),
            Card(name: "Lamelo", imageName: "girlFour", age: 19, bio: "Soy mucho bonita"),
            Card(name: "Steve", imageName: "girlFive", age: 30, bio: "que lito"),
            Card(name: "Borat", imageName: "girlSix", age: 40, bio: "Soy Amerika")
        ]
    }
}
