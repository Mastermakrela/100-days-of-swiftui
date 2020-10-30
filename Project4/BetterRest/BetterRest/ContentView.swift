//
//  ContentView.swift
//  BetterRest
//
//  Created by Krzysztof Kostrzewa on 30/10/2020.
//

import SwiftUI

var defaultWakeTime: Date {
    var components = DateComponents()
    components.hour = 7
    components.minute = 0
    return Calendar.current.date(from: components) ?? Date()
}

struct ContentView: View {
    let model = SleepCalculator()
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State var coffeeAmount: Int = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var output: some View {
        Section {
            Text("Your ideal bedtime is...")
                .font(.title3)
                .frame(maxWidth: .infinity)

            Text(calculatedBedtime)
                .font(.title)
                .frame(maxWidth: .infinity)
        }
        .padding(.bottom)
    }

    var dataInput: some View {
        Group {
            Section(header: Text("When do you want to wake up?")) {
                DatePicker("Please enter a date",
                           selection: $wakeUp,
                           in: Date()...)
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
            }

            Section(header: Text("Desired amount of sleep?")) {
                Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%.2g") hours")
                }
            }

            Section(header: Text("Daily coffee intake")) {
                Stepper(value: $coffeeAmount, in: 1 ... 20) {
                    coffeeAmount == 1 ? Text("1 cup") : Text("\(coffeeAmount) cups")
                }

//                    Picker("", selection: $coffeeAmount) {
//                        ForEach(1 ..< 21) {
//                            $0 == 1 ? Text("1 cup") :                                Text("\($0) cups")
//                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
            }
        }
    }

    var body: some View {
        NavigationView {
            Form {
                output

                dataInput
            }

            .navigationTitle("Better Rest")
        }
//        .alert(isPresented: $showingAlert) {
//            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
//        }
    }

    var calculatedBedtime: String {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            let df = DateFormatter()
            df.timeStyle = .short

            return df.string(from: sleepTime)

        } catch {
            return "..."
        }
    }

    func calculateBedtime() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            let df = DateFormatter()
            df.timeStyle = .short

            alertMessage = df.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."

        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, problem occured during bedtime calculation"
        }

        showingAlert.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
