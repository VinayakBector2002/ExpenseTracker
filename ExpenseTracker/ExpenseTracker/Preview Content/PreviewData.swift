//
//  PreviewData.swift
//  ExpenseTracker
//
//  Created by Vinayak Bector on 2022-04-25.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple", amount: 11.49, type: "debit", categoryId: 801, category: "Software", isPending: false, isTransfer: true, isExpense: true, isEdited: false)
var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
