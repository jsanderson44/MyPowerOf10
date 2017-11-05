//
//  HTMLParser+AthleteSearch.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

struct Athlete {
    
    let firstName: String
    let surname: String
    let ageGroup: String //TODO Create enum
    let gender: String //TODO Create enum
    let clubs: [String]
    
    // TODO Safe array
    // TODO Get athlete ID
    init(components: [String]) {
        firstName = components[1].trimmingCharacters(in: .whitespacesAndNewlines) //TODO String cleaned var
        surname = components[2].trimmingCharacters(in: .whitespacesAndNewlines)
        ageGroup = components[3].trimmingCharacters(in: .whitespacesAndNewlines)
        gender = components[6].trimmingCharacters(in: .whitespacesAndNewlines)
        clubs = components[7].trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "/")
    }
    
}

extension HTMLParser {
    
    func athletes() throws -> [Athlete] {
        var athletesToReturn: [Athlete] = []
        let athletes = document.css("#cphBody_dgAthletes tr").flatMap { athlete in
            return athlete.text
        }
        
        athletes.forEach { (athlete) in
            guard athlete != athletes.first else { return }
            let components = athlete.components(separatedBy: .newlines)
            let athleteToReturn = Athlete(components: components)
            athletesToReturn.append(athleteToReturn)
        }
        
        return athletesToReturn
    }
    
}
