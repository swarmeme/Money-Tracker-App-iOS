//
//  SwiftUIView.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 19/07/23.
//

import SwiftUI

struct TransactionRowView : View {
    var transaction: transaction
    var body: some View {
        HStack(spacing: 32){
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.icons)
                .opacity(0.3)
                .frame(width: 44, height: 44)
                      

            VStack(alignment: .leading, spacing: 6){
                //merchant text
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                //transcation category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                //transcation date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())//format is added to initialise the date in the right format
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
            //transaction amount
            Text(transaction.signedAmount, format: .currency(code: "INR"))
                .bold()
                .foregroundColor(transaction.type == transactionType.credit.rawValue ? Color.txt : .primary) // for debit and credit
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRowView(transaction: transactionPreviewData)
        //preview data is used to reduce the bundle size as it wont pile up in the final production
    }
}
