//
//  TransactionList.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 24/07/23.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM : TransactionListView
    var body: some View {
        VStack{
            List{
                //transaction groups
                ForEach(Array(transactionListVM.groupTransactionsByMonth()), id: \.key){
                    month, transactions in
                    Section{
                        //transactionList
                        ForEach(transactions) {
                            transaction in TransactionRowView(transaction: transaction)
                        }
                    } header: {
                        //transaction month
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
                
            }
            .listStyle(.plain)
            
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListView = {
        let transactionListVM = TransactionListView()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        NavigationView{
            TransactionList()
            }
        .environmentObject(transactionListVM)
        }
    }

