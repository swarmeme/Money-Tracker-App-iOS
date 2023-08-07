//
//  TransactionListView.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 22/07/23.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [transaction]>
typealias TransactionPrefixSum = [(String, Double)] //string represents date and double represents amt. prefix sum stands for cumulative sum. derived for data method.
final class TransactionListView: ObservableObject{
    @Published var transactions: [transaction] = [] //published will send notif to subscirbers when the value will change
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransaction()
    }
    
    func getTransaction() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("invalid")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump (response) //dump is like print but more readable form
                    throw URLError (.badServerResponse)
                }
                    return data
                }
              .decode(type: [transaction].self, decoder: JSONDecoder ())
              .receive(on: DispatchQueue.main)
              .sink { completion in
                  switch completion{
                  case .failure(let error):
                      print("Error in fetching transactions", error.localizedDescription)
                  case .finished:
                      print("Finished")
                  }
              } receiveValue: { [weak self]result in
                  self?.transactions = result //as we want to store the result in the transactions array
                  
              }
// sink processes the data. recCompl for handling success or failure cases, recValue for handling op.
              .store(in: &cancellables) //to cancel the subscription and free the data
            }
    func groupTransactionsByMonth() ->  TransactionGroup{
        guard !transactions.isEmpty else {return [:]}//guard so not empty array
        let groupedTransactions = TransactionGroup(grouping: transactions){$0.month}
        return groupedTransactions
    }//og transactions into dictionary form
    
    func accumulateTransactions() -> TransactionPrefixSum{
        print("accumulateTransactions")
        guard !transactions.isEmpty else {return []}
        
        let today = "18/05/2023".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        print(dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60*60*24){
            let dailyExpenses = transactions.filter{$0.dateParsed == date && $0.isExpensive}
            let dailyTotal = dailyExpenses.reduce(0) {$0 - $1.signedAmount}
            
            sum += dailyTotal
            sum = sum.rounded2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal", dailyTotal, "sum", sum)
        }
        return cumulativeSum
        
    }
        
    }

