//
//  ContentView.swift
//  Simple Converter
//
//  Created by Krzysztof Kostrzewa on 25/10/2020.
//

import SwiftUI

struct ConversionView<T: Dimension>: View {
    let title: String
    let units: [T]
    @State private var unitFrom: T
    @State private var unitTo: T
    @State private var textValue: String = ""

    private var value: Double { Double(textValue) ?? 0 }

    private var convertedValue: Measurement<T> {
        Measurement(value: value, unit: unitFrom).converted(to: unitTo)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Converted Value")) {
                    Text("\(convertedValue.value) \(convertedValue.unit.symbol)")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }

                Section(header: Text("Unit From")) {
                    Picker("Unit From", selection: $unitFrom) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Unit To")) {
                    Picker("Unit To", selection: $unitTo) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.symbol)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    TextField("Value to Convert", text: $textValue)
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
            }
            .navigationTitle(Text(title))
        }
    }

    // MARK: - Init

    init(title: String, units: [T]) {
        self.title = title
        self.units = units
        _unitFrom = State(initialValue: units[0])
        _unitTo = State(initialValue: units[1])
    }
}

struct ContentView: View {
    let unitsLength: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    let unitsTemperature: [UnitTemperature] = [.celsius, .fahrenheit]
    let unitsTime: [UnitDuration] = [.seconds, .minutes, .hours]
    let unitsVolume: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]

    var body: some View {
        TabView {
            ConversionView(title: "Length Conversion", units: unitsLength)
                .tabItem { Text("Length") }

            ConversionView(title: "Temperature Conversion", units: unitsTemperature)
                .tabItem { Text("Temperature") }

            ConversionView(title: "Time Conversion", units: unitsTime)
                .tabItem { Text("Time") }

            ConversionView(title: "Volume Conversion", units: unitsVolume)
                .tabItem { Text("Volume") }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
#endif
