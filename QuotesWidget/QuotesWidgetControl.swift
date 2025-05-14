//
//  QuotesWidgetControl.swift
//  QuotesWidget
//
//  Created by Jonathan Ricky Sandjaja on 14/05/25.
//

import AppIntents
import SwiftUI
import WidgetKit

struct QuoteEntry: TimelineEntry {
    var date: Date
    var quote: Quote?
}

struct QuoteProvider: TimelineProvider {
    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: Date(), quote: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping @Sendable (QuoteEntry) -> Void) {
        let entry = QuoteEntry(date: Date(), quote: nil)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<QuoteEntry>) -> Void) {
        fetchQuote { quote in
            let data = QuoteEntry(date: Date(), quote: quote)
            let timeline = Timeline(entries: [data], policy: .atEnd)
            completion(timeline)
        }
    }
    
    private func fetchQuote(completion: ((Quote) -> Void)?) {
        Task {
            do {
                let random: [Quote] = try await NetworkingManager.shared.getData(from: .random)
                if let quote = random.first {
                    completion?(quote)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
