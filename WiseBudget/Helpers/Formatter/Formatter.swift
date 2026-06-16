//
//  Formatter.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 19.06.2026.
//

import Foundation

enum AmountDisplayStyle {
    case normal
    case signed
    case currency
}

struct AmountFormatter {

    static func string(
        _ amount: Double,
        type: TransactionType? = nil,
        style: AmountDisplayStyle = .normal,
        currency: String? = nil,
        decimals: Int? = 0
    ) -> String {

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        
        if let decimals {
            formatter.maximumFractionDigits = decimals
            formatter.minimumFractionDigits = decimals
        } else {
            let hasDecimal = amount.truncatingRemainder(dividingBy: 1) != 0
            formatter.maximumFractionDigits = hasDecimal ? 2 : 0
            formatter.minimumFractionDigits = 0
        }

        let formatted = formatter.string(
            from: NSNumber(value: abs(amount))
        ) ?? "0"

        let sign: String

        switch style {
        case .normal:
            sign = ""

        case .signed, .currency:
            switch type {
            case .income:
                sign = "+"
            case .expense:
                sign = "-"
            case .transfer:
                sign = ""
            case .none:
                sign = ""
            }
        }

        if let currency {
            return "\(sign) \(formatted) \(currency)"
        }

        return "\(sign)\(formatted)"
    }
}
