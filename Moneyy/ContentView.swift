//
//  ContentView.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 18/07/23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListView
   // var demoData: [Double] = [8, 2, 4, 6, 12, 9, 2]
    var body: some View {
        
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 24){
                    //title
                    Text("Overview") //scrollview will take the size of this
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    //line chart
                    let data = transactionListVM.accumulateTransactions()
                    if !data.isEmpty{
                        let totalExpenses = data.last?.1 ?? 0
                        CardView {
                            VStack(alignment: .leading){
                                ChartLabel(totalExpenses.formatted(.currency(code: "INR")), type: .title, format: "₹%0.2f")
                                LineChart()
                            }.background(Color.systembg)
                                
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systembg, foregroundColor: ColorGradient(Color.icons.opacity(0.4), Color.icons)))
                    .frame(height: 250)
                    }
                   
                
                    
                        //transaction list
                    RecentTransactionList()
                    
                }
                .padding()
                .frame(maxWidth: .infinity) //to make the enitre screen pink as w padding we didnt have it
            }
            .background(Color.bg)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //for notif bell
                Image(systemName: "bell.badge")
                    .symbolRenderingMode(.palette) //to custom color item
                    .foregroundStyle(Color.icons, .primary)
            }
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListView = {
        let transactionListVM = TransactionListView()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
        
}
