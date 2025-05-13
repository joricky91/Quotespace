//
//  HomeView.swift
//  Quotespace
//
//  Created by Jonathan Ricky Sandjaja on 16/04/25.
//

import SwiftUI
import SwiftData
import UserNotifications
import BackgroundTasks

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = HomeViewModel()
    @State private var navigateToFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("quotespace")
                        .font(.title)
                        .fontWeight(.light)
                    
                    Spacer()
                    
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .onTapGesture {
                            navigateToFavorite = true
                        }
                }
                
                Spacer()
                
                VStack(alignment: .center) {
                    Text("\"\(viewModel.randomQuote?.q ?? "")\"")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    Text("- \(viewModel.randomQuote?.a ?? "") -")
                        .font(.title3)
                }
                .padding(.bottom)
                
                HStack(spacing: 24) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .frame(width: 28, height: 32)
                        .onTapGesture {
                            viewModel.getRandomQuote(modelContext: modelContext)
                        }
                    
                    Image(systemName: viewModel.systemIcon)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(viewModel.iconColor)
                        .onTapGesture {
                            viewModel.saveQuotesToLocal(modelContext: modelContext)
                        }
                    
                    ShareLink(item: viewModel.randomQuote?.q ?? "") {
                        Image(systemName: "square.and.arrow.up")
                            .resizable()
                            .frame(width: 28, height: 36)
                    }
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $navigateToFavorite) {
                FavoritesView()
            }
        }
        .onAppear {
            viewModel.getRandomQuote(modelContext: modelContext)
            askNotificationPermission()
        }
    }
    
    func askNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Nice! Now you can get daily quotes notification!")
                generateLocalNotification()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func generateLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Quotes"
        content.body = "Check your daily quotes now to help you though the day!"
        content.sound = .default
        
        var datComp = DateComponents()
        datComp.hour = 07
        datComp.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: datComp, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

//#Preview {
//    HomeView()
//}

extension Date {
    static func createCustomDate(hour: Int, minute: Int) -> Date {
        let now = Date()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: now)
        
        var components = calendar.dateComponents([.year, .month, .day], from: today)
        components.hour = hour
        components.minute = minute

        if let customDate = calendar.date(from: components) {
            return customDate
        } else {
            return now
        }
    }
}
