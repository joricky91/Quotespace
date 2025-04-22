//
//  FavoritesView.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 17/04/25.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var items: [LocalQuote]
    
    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                VStack(alignment: .leading) {
                    Text(item.quote)
                        .font(.title3)
                    
                    Text("- \(item.author)")
                }
            }
            .onDelete { indexSet in
                if let index = indexSet.first {
                    SwiftDataManager.shared.deleteItem(context: modelContext,
                                                       data: items[index])
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    FavoritesView()
}
