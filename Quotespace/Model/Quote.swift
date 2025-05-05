//
//  Quote.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation

struct Quote: Codable {
    var q: String
    var a: String
    var h: String
    
    func toLocalQuote() -> LocalQuote {
        let local = LocalQuote(quote: q,
                               author: a,
                               isFavorite: true)
        return local
    }
}
