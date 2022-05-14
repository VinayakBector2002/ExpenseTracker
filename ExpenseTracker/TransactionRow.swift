//
//  TransactionRow.swift
//  ExpenseTracker
//
//  Created by Vinayak Bector on 2022-04-25.
//

import SwiftUI
import SwiftUIFontIcon

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20){
            // MARK: Transaction Category Icon
            RoundedRectangle (cornerRadius: 20, style: .continuous)
                .fill(Color.icon.opacity(0.3))
                .frame(width: 44, height: 44)
                .overlay{
                    FontIcon.text(.awesome5Solid(code: transaction.icon),fontsize: 24, color: .icon)
                }
            
            
            VStack(alignment: .leading, spacing: 6){
                // MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                // MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                /*
                 We need to use some lib to convert string data type to swift datetime 
                 */
                // MARK: Transaction Date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            // MARK: Debug spacer
            
            /*
             This looks ugly here but the end result looks much more better because of the addition of spacer
             */
            Spacer()
            
            // MARK: Transaction Amount
            Text(transaction.signedAmount, format: .currency(code: "CAD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ?
                                 Color.text: .primary)
            
        }
        .padding([.top,.bottom], 8)
        
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View{
        Group{
            TransactionRow(transaction: transactionPreviewData)
            TransactionRow(transaction: transactionPreviewData)
                .preferredColorScheme(.dark)
        }
    }
}
