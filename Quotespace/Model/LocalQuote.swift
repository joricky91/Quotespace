//
//  LocalQuote.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 17/04/25.
//

import SwiftData

@Model
final class LocalQuote {
    var quote: String
    var author: String
    
    init (quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
}
