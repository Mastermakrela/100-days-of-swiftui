//
//  ContentView.swift
//  MultiPlaying
//
//  Created by Krzysztof Kostrzewa on 04/11/2020.
//

import SwiftUI

enum Pages {
    case home, game, result
}

struct ContentView: View {
    @State private var currentPage: Pages = .home

    @State private var rangeSelection = (6, 6)
    @State private var questionsNumber = 5
    @State private var questions: [(Int, Int, Int)] = []

    var body: some View {
        NavigationView {
            switch currentPage {
            case .home: HomeView {
                    questions = $0
                    currentPage = .game
                }
                .transition(.slide)

            case .game:
                GameView(questions: $questions)
                    .transition(.slide)

            case .result:
                Text("result")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
