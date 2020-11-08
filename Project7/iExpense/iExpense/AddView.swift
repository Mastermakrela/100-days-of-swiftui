//
//  AddView.swift
//  iExpense
//
//  Created by Krzysztof Kostrzewa on 07/11/2020.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type: ExpenseType = .personal
    @State private var amount = ""

    var disabled: Bool {
        name.isEmpty || Double(amount) == nil
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)

                Picker("type", selection: $type) {
                    ForEach(ExpenseType.allCases) {
                        Text($0.name)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationTitle("Add new expense")
            .navigationBarItems(trailing:
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: Double(amount) ?? 0)
                    expenses.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(disabled)
            )
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
