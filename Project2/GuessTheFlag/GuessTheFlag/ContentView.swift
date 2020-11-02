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
    @State private var animationAmount = 0.0
    @State private var animationOpacity = 1.0
    @State private var animationAmount2 = 0.0
    @State private var animationOpacity2 = 1.0

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
                        if number == correctAnswer {
                            scoreTitle = "Correct"
                            withAnimation(.linear(duration: 1)) {
                                animationAmount += 360
                                animationOpacity = 0.25
                            }
                        } else {
                            scoreTitle = "Wrong"
                            withAnimation(.linear(duration: 1)) {
                                animationAmount2 += 360
                                animationOpacity = 0.25
                                animationOpacity = 0.25
                            }
                        }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            showingScore.toggle()
                        }

                    } label: {
//                        Image(countries[number])
//                            .renderingMode(.original)
//                            .clipShape(Capsule())
//                            .overlay(
//                                Capsule().stroke(Color.black, lineWidth: 1)
//                            )
//                            .shadow(color: .black, radius: 2)
                        if number == correctAnswer {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                                .rotation3DEffect(.degrees(animationAmount2), axis: (x: 1, y: 1, z: 1))
                                .opacity(animationOpacity2)
                        } else {
                            FlagImage(country: countries[number])
                                .opacity(animationOpacity)
                                .rotation3DEffect(.degrees(animationAmount2), axis: (x: 1, y: 1, z: 1))
                                .opacity(animationOpacity2)
                        }
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
        animationOpacity = 1
        animationAmount = 0
        animationOpacity2 = 1
        animationAmount2 = 0
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
