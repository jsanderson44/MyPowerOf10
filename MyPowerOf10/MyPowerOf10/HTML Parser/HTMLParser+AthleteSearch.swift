//
//  HTMLParser+AthleteSearch.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

extension HTMLParser {
    
    func athletesFromSearchResults() -> [Athlete] {
        var athletes: [Athlete] = document.css("#cphBody_dgAthletes tr").flatMap { (athlete) in
            guard let profileHTML = athlete.css("a[href]").first?.toHTML,
                var components = athlete.text?.components(separatedBy: .newlines) else { return nil }
            components.append(profileHTML)
            return Athlete(components: components)
        }
        athletes.removeFirst()
        return athletes
    }
    
}
