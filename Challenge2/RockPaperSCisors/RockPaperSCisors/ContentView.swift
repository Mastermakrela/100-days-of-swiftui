//
//  ContentView.swift
//  RockPaperSCisors
//
//  Created by Krzysztof Kostrzewa on 29/10/2020.
//

import SwiftUI

struct ContentView: View {
    @State var appSelected: Move? = nil
    @State var text = "..."
    @State var round = 1
    @State var appScore = 0
    @State var yourScore = 0
    @State var isShowingResult = false

    var game: some View {
        VStack {
            Text("Round \(round)/10")
                .font(.title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color.secondary.opacity(0.1)))
                .padding(.horizontal)

            VStack {
                Text("Score")
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    Text("You").fontWeight(.semibold)
                    Text("App").fontWeight(.semibold)
                    Text("\(yourScore)")
                    Text("\(appScore)")
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color.secondary.opacity(0.1)))
            .padding([.horizontal, .bottom])

            VStack {
                Text("Apps Move")
                    .font(.headline)
                    .padding(.bottom)

                Text("\(appSelected?.rawValue ?? "")")
                    .font(.system(size: 64))
            }
            .frame(maxWidth: .infinity)
            .padding().background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color.secondary.opacity(0.1)))
            .padding(.horizontal)

            Text(text)
                .font(.title)
                .foregroundColor(text == "..." ? .primary : text == "You won" ? .green : .red)
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color.secondary.opacity(0.1)))
                .padding(.horizontal)

            VStack {
                Text("Select your move")
                    .font(.headline)
                    .padding(.bottom)
                HStack {
                    Spacer()
                    Button("🪨") { userSelected(move: .rock) }
                    Spacer()
                    Button("📄") { userSelected(move: .paper) }
                    Spacer()
                    Button("✂️") { userSelected(move: .scisors) }
                    Spacer()
                }
                .font(.system(size: 64))
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color.secondary.opacity(0.1)))
            .padding(.horizontal)
            .disabled(isShowingResult)
            .redacted(reason: isShowingResult ? .placeholder : [])
        }
    }

    var resultText: (String, Color) {
        if appScore == yourScore {
            return ("It's a draw", .yellow)
        } else if yourScore > appScore {
            return ("You won", .green)
        } else {
            return ("You lost", .red)
        }
    }

    var result: some View {
        VStack(spacing: 40.0) {
            Text("Game Over")
                .font(.largeTitle)

            Text(resultText.0)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(resultText.1)

            Button("Play Again") {
                appSelected = nil
                text = "..."
                round = 1
                appScore = 0
                yourScore = 0
                isShowingResult = false
            }
            .background(Capsule().foregroundColor(.green))
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if round <= 10 {
                    game
                } else {
                    result
                }
            }
            .navigationTitle("Rock Paper Scisors")
        }
        .animation(.default)
    }

    func userSelected(move: Move) {
        round += 1
        let userWon = Bool.random()

        if userWon {
            appSelected = move.better
            text = "You won"
            yourScore += 1
        } else {
            appSelected = move.worse
            text = "You lost"
            appScore += 1
        }
        isShowingResult = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            appSelected = nil
            text = "..."
            isShowingResult = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Move: String, CaseIterable {
    case rock = "🪨"
    case paper = "📄"
    case scisors = "✂️"

    var better: Move {
        switch self {
        case .rock:
            return .paper
        case .paper:
            return .scisors
        case .scisors:
            return .rock
        }
    }

    var worse: Move {
        switch self {
        case .rock:
            return .scisors
        case .paper:
            return .rock
        case .scisors:
            return .paper
        }
    }
}
