//
//  MoneyyApp.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 18/07/23.
//

import SwiftUI

@main
struct MoneyyApp: App {
    @StateObject var transactionListVM = TransactionListView() //stateobj used so this variable can follow the life cycle of the app
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
