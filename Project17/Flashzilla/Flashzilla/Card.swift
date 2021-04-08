//
//  Card.swift
//  Flashzilla
//
//  Created by Krzysztof Kostrzewa on 07.04.21.
//

struct Card: Codable {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
