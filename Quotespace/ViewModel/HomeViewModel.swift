//
//  HomeViewModel.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation
import SwiftData
import SwiftUI
import BackgroundTasks

@MainActor
@Observable class HomeViewModel {
    
    var randomQuote: Quote?
    var systemIcon: String = "heart"
    var iconColor: Color = .primary
    
    func getRandomQuote(modelContext: ModelContext) {
        Task {
            do {
                let random: [Quote] = try await NetworkingManager.shared.getData(from: .random)
                self.randomQuote = random.first
                getCurrentLocalQuotes(modelContext: modelContext,
                                      quote: random.first?.q ?? "")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func saveQuotesToLocal(modelContext: ModelContext) {
        let quote = randomQuote?.toLocalQuote()
        if let quote {
            SwiftDataManager.shared.addToLocal(context: modelContext,
                                               data: quote)
            setIconSaved()
        }
    }
    
    func getCurrentLocalQuotes(modelContext: ModelContext, quote: String) {
        let predicate = #Predicate<LocalQuote> {
            $0.quote == quote
        }
        
        let localQuote = SwiftDataManager.shared.fetchOne(context: modelContext,
                                                          predicate: predicate)
        if let _ = localQuote {
            setIconSaved()
        } else {
            resetIcon()
        }
    }
    
    func setIconSaved() {
        systemIcon = "heart.fill"
        iconColor = .red
    }
    
    func resetIcon() {
        systemIcon = "heart"
        iconColor = .primary
    }

}
