//
//  ContentView.swift
//  WeSplit
//
//  Created by Krzysztof Kostrzewa on 22/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]

    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }

    var totalPerPerson: Double { grandTotal / (Double(numberOfPeople) ?? 1) }
    
    var tipIsZero: Bool { tipPercentages[tipPercentage] == 0 }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

//                    Picker("Number of People", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) pople")
//                        }
//                    }

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                        .foregroundColor(tipIsZero ? .red : .primary)
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }

            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
