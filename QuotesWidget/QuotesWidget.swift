//
//  QuotesWidget.swift
//  QuotesWidget
//
//  Created by Jonathan Ricky Sandjaja on 14/05/25.
//

import WidgetKit
import SwiftUI

struct QuotesWidgetView: View {
    var entry: QuoteProvider.Entry
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(entry.quote?.q ?? "")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.primary)
                .multilineTextAlignment(.leading)
                .lineSpacing(4)

            Text("- \(entry.quote?.a ?? "")")
                .font(.footnote)
                .foregroundColor(Color.secondary)
        }
    }
}

@main
struct QuotesWidget: Widget {
    let kind: String = "QuotesWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: QuoteProvider()) { entry in
            if #available(iOS 17.0, *) {
                QuotesWidgetView(entry: entry)
                    .containerBackground(.widgetBackground, for: .widget)
            } else {
                QuotesWidgetView(entry: entry)
                    .padding()
                    .background(.widgetBackground)
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemSmall) {
    QuotesWidget()
} timeline: {
    QuoteEntry(date: .now, quote: Quote(q: "I'm gonna be the king of the pirates", a: "Monkey D. Luffy", h: ""))
    QuoteEntry(date: .now, quote: Quote(q: "I'm gonna be the king of the pirates", a: "Monkey D. Luffy", h: ""))
}
