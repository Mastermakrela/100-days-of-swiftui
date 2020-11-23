//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Krzysztof Kostrzewa on 19/11/2020.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your caketype", selection: $order.type) {
                        ForEach(0 ..< Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Stepper(value: $order.quantity) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }

                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()) {
                        Text("Any special requsts?")
                    }

                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add extra frosting")
                        }
                    }
                }

                Section {
                    NavigationLink(
                        destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcacke Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
