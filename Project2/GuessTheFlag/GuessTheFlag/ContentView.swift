//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Krzysztof Kostrzewa on 25/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var showingScore = false
    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .font(.title)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
                .foregroundColor(.white)

                ForEach(0 ..< 3) { number in
                    Button {
                        scoreTitle = number == correctAnswer ? "Correct" : "Wrong"
                        showingScore.toggle()
                    } label: {
//                        Image(countries[number])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(
//                                Capsule().stroke(Color.black, lineWidth: 1)
//                            )
//                            .shadow(color: .black, radius: 2)
                        FlagImage(country: countries[number])
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is ???"), dismissButton: .default(Text("Continue"), action: askQuestion))
        }
    }

    // MARK: - Functions

    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(
                Capsule().stroke(Color.black, lineWidth: 1)
            )
            .shadow(color: .black, radius: 2)
    }
}
