//
//  ContentView.swift
//  Accessibility
//
//  Created by Krzysztof Kostrzewa on 02.04.21.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
    ]

    let labels = [
        "Tulips",
        "Frozen tree buds",
    ]

    @State private var selectedPicture = Int.random(in: 0 ... 1)
    @State private var estimate = 25.0
    @State private var rating = 3

    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()

            .accessibility(label: Text(labels[selectedPicture]))
            .accessibility(addTraits: .isButton)
            .accessibility(removeTraits: .isImage)

            .onTapGesture {
                self.selectedPicture = Int.random(in: 0 ... 1)
            }

        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .combine)

        Slider(value: $estimate, in: 0 ... 50)
            .padding()
            .accessibility(value: Text("\(Int(estimate))"))

        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1 ... 5)
//            .accessibility(value: Text("\(rating) out of 5"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
