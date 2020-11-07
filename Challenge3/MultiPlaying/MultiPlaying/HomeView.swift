//
//  HomeView.swift
//  MultiPlaying
//
//  Created by Krzysztof Kostrzewa on 07/11/2020.
//

import SwiftUI

struct HomeView: View {
    @State private var rangeSelection = (6, 6)
    @State private var questionsNumber = 5
    let onStart: ([(Int, Int, Int)]) -> Void

    private var disable: Bool {
        questionsNumber > 0 && rangeSelection.0 * rangeSelection.1 < questionsNumber
    }

    var body: some View {
        VStack {
            VStack {
                Text("Select Multiplication table size")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                DoubleRangeSelector(xRange: 1 ... 12, yRange: 1 ... 12, selection: $rangeSelection)
                    .padding()
            }
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.secondary)
            )

            VStack {
                Text("How may question do you want to answer?")
                    .fontWeight(.semibold)
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

                Picker("Number of Questions", selection: $questionsNumber) {
                    Text("5").tag(5)
                    Text("10").tag(10)
                    Text("20").tag(20)
                    Text("All").tag(-1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.secondary)
            )

            Spacer()

            Button {
                let table = (1 ... rangeSelection.0).flatMap { num1 in
                    (1 ... rangeSelection.1).map { num2 in
                        (num1, num2, num1 * num2)
                    }
                }.shuffled()

                let questions = questionsNumber == -1
                    ? table
                    : Array(table[0 ..< questionsNumber])

                onStart(questions)
            }
            label: {
                Text("Start")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding()
                    .background(
                        Capsule()
                            .foregroundColor(disable ? .gray : .green)
                    )
                    .animation(.default)
            }
            .disabled(disable)
        }
        .padding()
        .navigationTitle("MultiPlaying")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(onStart: { _ in })
    }
}
