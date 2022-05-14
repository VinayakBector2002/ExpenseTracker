//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Vinayak Bector on 2022-04-24.
//

import SwiftUI
import SwiftUICharts
import LocalAuthentication


struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 24){
            
            Text("Overview")
                .font(.title2)
                .bold()
            padding()
            Text("No New Notifications")
                .font(.callout)
            padding()
            padding()
                Button("Press to dismiss") {
                    dismiss()
                }
                .font(.title)
                .padding()
                .background(Color.primary)
                
            }
        }
    
}

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @State private var isUnlocked = false
    @State private var showingSheet = false

    var body: some View {
       
        NavigationView{
            if isUnlocked {
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    // MARK: Title
                    Text("Overview")
                        .font(.title2)
                        .bold()
                    
                    // MARK: Line Chart
                    let data = transactionListVM.accumulateTransactions()
                    
                    if !data.isEmpty {
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "CAD")),type: .title, format: "CA$%.02f")
                                LineChart()
                            }
                            .background(Color.systemBackground)
                                
                            
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    }
                    
                    
                    
                    
                    // MARK: Transaction List
                    RecentTransactionList()
                }
                .padding()
                .frame( maxWidth: .infinity)
                
            }
            .background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundColor(Color.icon)
                        .onTapGesture {
                            showingSheet.toggle()
                        }.sheet(isPresented: $showingSheet){
                            SheetView()
                        }
                }
            }
            } else {
                VStack(alignment: .leading, spacing: 24){
                    // MARK: Auth Failed
                    Text("Authentication Failed, Please Try Again :)")
                        .font(.title2)
                        .bold()
                }.navigationViewStyle(.stack)
                    .accentColor(.primary)
            
        }
        }
        .onAppear(perform: authentication)
    }
    
    func authentication() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "To see your financies"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason){ success, authenticationError in
                if success {
                    // authentication was successful
                    isUnlocked = true
                    
                } else {
                    // authentication failed
                }
                
            }
        } else {
            // Authentication Failed
            print("No Bio metrics")
            
        }
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
        // This is similar to date formatter
    }()
    
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(transactionListVM)
    }
}
