//
//  DoubleExtensions.swift
//  Exercise
//
//  Created by yoga arie on 21/07/24.
//

import Foundation

extension Double {
  func formattedAsCurrency() -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "Rp"
    formatter.currencyGroupingSeparator = "."
    formatter.currencyDecimalSeparator = ","
    formatter.maximumFractionDigits = 0
    return formatter.string(from: NSNumber(value: self)) ?? "Rp0"
  }
}
