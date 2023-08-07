//
//  RecentTransactionList.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 23/07/23.
//

import SwiftUI

struct RecentTransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListView
    var body: some View {
        VStack{
            HStack{
                Text("Recent Transactions") //title
                    .bold()
                
                Spacer()
                
                //header link
                NavigationLink {
                    TransactionList()
                } label: {
                    HStack(spacing: 4){
                        Text("See All")
                        Image(systemName: "chevron.right")
                        
                    }
                    .foregroundColor(Color.txt)
                }

            }
            .padding(.top)
            
            //recent transaction list
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()), id: \.element){
                index, transaction in TransactionRowView(transaction: transaction	)
                Divider()
                    .opacity(index == 4 ? 0:1)
            }
        }
        .padding()
        .background(Color.systembg)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity(0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    static let transactionListVM: TransactionListView = {
        let transactionListVM = TransactionListView()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }() //enforce a diff value to VM for preview
    static var previews: some View {
        RecentTransactionList()
            .environmentObject(transactionListVM)
    }
}
