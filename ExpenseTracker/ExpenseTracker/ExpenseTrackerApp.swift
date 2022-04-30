//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Vinayak Bector on 2022-04-24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
