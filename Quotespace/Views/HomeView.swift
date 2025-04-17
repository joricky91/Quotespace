//
//  HomeView.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = HomeViewModel()
    @Query var items: [LocalQuote]
    
    var body: some View {
        VStack {
            HStack {
                Text("quotespace")
                    .font(.title)
                    .fontWeight(.light)
                
                Spacer()
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Text("\"\(viewModel.randomQuote?.quote ?? "")\"")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("- \(viewModel.randomQuote?.author ?? "") -")
                    .font(.title3)
            }
            .padding(.bottom)
            
            HStack(spacing: 16) {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 28, height: 32)
                    .onTapGesture {
                        viewModel.getRandomQuote()
                    }
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .onTapGesture {
                        viewModel.saveQuotesToLocal(modelContext: modelContext)
                    }
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.getRandomQuote()
        }
    }
}

//#Preview {
//    HomeView()
//}
