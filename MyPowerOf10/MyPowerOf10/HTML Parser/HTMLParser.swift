//
//  HTMLParser.swift
//  MyPowerOf10
//
//  Created by John Sanderson on 05/11/2017.
//  Copyright © 2017 JohnSanderson. All rights reserved.
//

import Foundation
import Kanna

enum HTMLParsingError: Error {
    case cssSelectorNotFound
    case keyNotFound
    case textNotFound
}

/// A HTML parser that can be used to extra values from HTML using CSS selectors
struct HTMLParser {
    
    let document: HTMLDocument
    
    public init(htmlData: Data) throws {
        let document = try HTML(html: htmlData, encoding: .utf8)
        self.document = document
    }
    
    /// Returns a value from the `HTMLDocument` based on the provided
    /// css selector and key.
    ///
    /// - Parameters:
    ///   - cssSelector: The css selector for the required element
    ///   - key: The key of the required value from within the element
    /// - Returns: String of value parsed from HTML
    /// - Throws: `HTMLParsingError`
    public func textForCSSSelector(_ cssSelector: String, key: String) throws -> String {
        for element in document.css(cssSelector) {
            guard let value = element[key] else {
                throw HTMLParsingError.keyNotFound
            }
            return value
        }
        throw HTMLParsingError.cssSelectorNotFound
    }
    
    /// Returns a value from the `HTMLDocument` based on the provided
    /// css selector.
    ///
    /// - Parameters:
    ///   - cssSelector: The css selector for the required element
    /// - Returns: String of the text of the parsed element from HTML
    /// - Throws: `HTMLParsingError`
    public func textForCSSSelector(_ cssSelector: String) throws -> String {
        for element in document.css(cssSelector) {
            guard let value = element.text else {
                throw HTMLParsingError.textNotFound
            }
            return value
        }
        throw HTMLParsingError.cssSelectorNotFound
    }
    
}
