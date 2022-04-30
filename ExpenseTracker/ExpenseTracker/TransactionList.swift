//
//  TransactionList.swift
//  ExpenseTracker
//
//  Created by Vinayak Bector on 2022-04-29.
//

import SwiftUI

struct TransactionList: View {
    
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    
    var body: some View {
        VStack{
            List{
                // MARK: Transaction Groups
                ForEach(Array(transactionListVM.groupTransactionByMonth()), id: \.key)
                {
                    month, transactions in

                    Section{
                        // MARK: Transaction List
                        ForEach(transactions)
                        {
                            transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                    // MARK: Transaction Month
                    Text(month)
                }
                .listSectionSeparator(.hidden)
                }
                
            }
                
            
            
        }.navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            NavigationView {
                TransactionList()
            }
            NavigationView {
                TransactionList()
                    .preferredColorScheme(.dark)
            }
            
        }
    }
}
