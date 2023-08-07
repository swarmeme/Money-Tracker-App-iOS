//
//  PreviewData.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 19/07/23.
//

import Foundation
import SwiftUI

var transactionPreviewData = transaction(id: 1, date: "91/24/2022", institution: "Desjardins", account: "Visa Desjardins", merchant: "Apple",
                                         amount: 11.49, type: "debit", categoryID: 801, category: "Software", isPending: false, isTransfer: false, isExpensive: true, isEdited: false)
var transactionListPreviewData = [transaction] (repeating: transactionPreviewData, count: 10)
