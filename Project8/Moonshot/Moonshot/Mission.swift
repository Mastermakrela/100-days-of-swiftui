//
//  Mission.swift
//  Moonshot
//
//  Created by Krzysztof Kostrzewa on 08/11/2020.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String

    var displayName: String { "Apollo \(id)" }

    var image: String { "apollo\(id)" }

    var formattedLauchDate: String {
        guard let launchDate = launchDate else { return "N/A" }

        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: launchDate)
    }

    func getCrewNames(_ astronauts: [Astronaut] = []) -> String {
        crew
            .map(\.name)
            .map { name in astronauts.first { $0.id == name }?.name ?? name }
            .joined(separator: ",\n")
    }
}
