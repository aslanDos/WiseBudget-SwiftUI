//
//  Double.ext.swift
//  WiseBudget
//
//  Created by Aslan Dossymzhan 2 on 19.06.2026.
//

import Foundation

extension Double {
    func formattedAmount(
        type: TransactionType? = nil,
        currency: String? = nil,
        decimals: Int? = nil
    ) -> String {
        AmountFormatter.string(
            self,
            type: type,
            style: .currency,
            currency: currency,
            decimals: decimals
        )
    }
}
