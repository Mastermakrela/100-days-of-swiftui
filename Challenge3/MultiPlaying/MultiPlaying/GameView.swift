//
//  GameView.swift
//  MultiPlaying
//
//  Created by Krzysztof Kostrzewa on 07/11/2020.
//

import SwiftUI

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title, design: .rounded))
            .padding()
            .background(
                Circle()
                    .foregroundColor(.green)
            )
    }
}

struct GameView: View {
    @Binding var questions: [(Int, Int, Int)]
    @State private var input = " "

    var question: (Int, Int, Int) { questions.first! }

    var body: some View {
        VStack {
            Text("How much is?")
                .font(.title)

            Text("\(question.0) x \(question.1)")
                .font(.largeTitle)
                .padding()

            Text("\(input)")

            VStack {
                HStack { ForEach(7 ..< 10) { Text("\($0)").modifier(ButtonStyle()) } }
                HStack { ForEach(4 ..< 7) { Text("\($0)").modifier(ButtonStyle()) } }
                HStack { ForEach(1 ..< 4) { Text("\($0)").modifier(ButtonStyle()) } }
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(questions: .constant([(2, 2, 4), (7, 7, 49)]))
    }
}
