//
//  HomeViewModel.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation
import SwiftData

@MainActor
@Observable class HomeViewModel {
    
    var randomQuote: Quote?
    
    func getRandomQuote() {
        Task {
            do {
                let random: Quote = try await NetworkingManager.shared.getData(from: .random)
                self.randomQuote = random
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveQuotesToLocal(modelContext: ModelContext) {
        let quote = randomQuote?.toLocalQuote()
        if let quote = quote {
            SwiftDataManager.shared.addToLocal(context: modelContext,
                                               data: quote)
        }
    }

}
