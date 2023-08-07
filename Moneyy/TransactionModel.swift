//
//  TransactionModel.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 19/07/23.
//

import Foundation

struct transaction:Identifiable, Decodable, Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    var type: transactionType.RawValue
    var categoryID: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpensive: Bool
    var isEdited: Bool
    
    var dateParsed: Date {
        date.dateParsed()
    }
    
    var signedAmount: Double{
        return type == transactionType.credit.rawValue ? amount : -amount
    }
    
    var month: String{
        dateParsed.formatted(.dateTime.year().month(.wide)) //wide used for full month 
    }
}

enum transactionType: String { //enum to define custom words which can be used else trigger an alert
    case debit = "debit"
    case credit = "credit"
    
}
