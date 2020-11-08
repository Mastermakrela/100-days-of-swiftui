//
//  ContentView.swift
//  iExpense
//
//  Created by Krzysztof Kostrzewa on 07/11/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type.name)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .foregroundColor(
                                item.amount <= 10
                                    ? .green
                                    : item.amount <= 100
                                    ? .orange
                                    : .red
                            )
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .navigationBarItems(leading: EditButton())
            .navigationBarItems(trailing:
                Button {
                    showingAddExpense.toggle()
                }
                label: {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }

    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
