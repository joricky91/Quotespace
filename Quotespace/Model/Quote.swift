//
//  Quote.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation

struct Quote: Codable {
    var id: Int
    var quote: String
    var author: String
    
    func toLocalQuote() -> LocalQuote {
        let local = LocalQuote(id: id,
                               quote: quote,
                               author: author,
                               isFavorite: true)
        return local
    }
}
