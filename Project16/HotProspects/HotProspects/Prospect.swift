//
//  Prospect.swift
//  HotProspects
//
//  Created by Krzysztof Kostrzewa on 06.04.21.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    private let fileUrl = URL.documentsDirectory!.appendingPathComponent("people.json")

    @Published private(set) var people: [Prospect]

    init() {
        people = []

        if let data = try? Data(contentsOf: fileUrl),
           let decodedData = try? JSONDecoder().decode([Prospect].self, from: data)
        {
            people = decodedData
        }
    }

    private func save() {
        guard let encoded = try? JSONEncoder().encode(people) else { return }

        do {
            try encoded.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }

    func add(_ person: Prospect) {
        people.append(person)
        save()
    }
}

extension URL {
    static var documentsDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
