//
//  HomeView.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import SwiftUI

struct HomeView: View {
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
                Text("\"The important thing is not to stop questioning. Curiosity has its own reason for existing.\"")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Text("- Albert Einstein -")
                    .font(.title3)
            }
            .padding(.bottom)
            
            HStack(spacing: 16) {
                Image(systemName: "arrow.clockwise")
                    .resizable()
                    .frame(width: 28, height: 32)
                
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .padding(.top)
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
