//
//  LocalQuote.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 17/04/25.
//

import SwiftData

@Model
final class LocalQuote {
    var id: Int
    var quote: String
    var author: String
    var isFavorite: Bool
    
    init(id: Int, quote: String, author: String, isFavorite: Bool) {
        self.id = id
        self.quote = quote
        self.author = author
        self.isFavorite = isFavorite
    }
}
