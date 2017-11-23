//
//  AthleteResult.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
    case unknown = "Unknown"
}

extension Gender {
    
    init(parsedValue: String) {
        switch parsedValue {
        case "M": self = .male
        case "W": self = .female
        default: self = .unknown
        }
    }
}

struct AthleteResult {
    
    let firstName: String
    let surname: String
    let ageGroup: String //TODO Create enum?
    let gender: Gender
    let clubs: [String]
    let athleteID: String?
    
}

extension AthleteResult {
    // TODO Safe array
    init(components: [String]) {
        firstName = components[2].cleaned.removeTags.removeAmpersand()
        surname = components[3].cleaned.removeTags.removeAmpersand()
        ageGroup = components[4].cleaned.removeTags.removeAmpersand()
        gender = Gender(parsedValue: components[7].cleaned.removeTags.removeAmpersand())
        clubs = components[8].cleaned.removeTags.removeAmpersand().components(separatedBy: "/")
        athleteID = components.last?.digitsOnly
    }
}
