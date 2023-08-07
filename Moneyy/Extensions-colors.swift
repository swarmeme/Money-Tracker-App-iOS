//
//  Extensions-colors.swift
//  Moneyy
//
//  Created by Swarnim Varshneya on 18/07/23.
//

import Foundation
import SwiftUI

extension Color { //done to access colors easier which we made
    static let bg = Color("bg")
    static let icons = Color("icons")
    static let txt = Color("txt")
    static let systembg = Color(uiColor: .systemBackground)
    
}

extension DateFormatter{
    static let allNumericIND: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "DD/MM/YYYY"
        return formatter
    }() // lazy method and expensive op so initialise once only
}

extension String{
    func dateParsed() -> Date{
        guard DateFormatter.allNumericIND.date(from: self) != nil else {return Date()}//guard is used to ensure this op is executed or else the else section will be done
        return dateParsed()
    }
}

extension Date: Strideable{
    func formatted() -> String{
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double{
    func rounded2Digits() -> Double{
        return (self * 100).rounded() / 100 // this is done to round off to 2 digits as the console was showing multiple elements
    }
}
