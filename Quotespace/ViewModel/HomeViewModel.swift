//
//  HomeViewModel.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import Foundation

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

}
