//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Krzysztof Kostrzewa on 07/11/2020.
//

import Foundation

enum ExpenseType: String, CaseIterable, Identifiable, Codable {
    case personal, buissness

    var id: ExpenseType { self }
    var name: String { "\(self)" }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}
