//
//  FileReader.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 05.04.21.
//

import SwiftUI

@propertyWrapper
// struct Document<Content: Codable>: DynamicProperty {
struct Document: DynamicProperty {
    @State private var data: [Person] = []
    let fileUrl: URL

    init(_ file: String) {
        fileUrl = URL.documentsDirectory!.appendingPathComponent(file)

        if let data = try? Data(contentsOf: fileUrl),
           let decodedData = try? JSONDecoder().decode([Person].self, from: data)
        {
            _data = State(initialValue: decodedData)
        }
    }

    var wrappedValue: [Person] {
        get { data }
        nonmutating set {
            data = newValue

            do {
                let data = try JSONEncoder().encode(data)
                try data.write(to: fileUrl, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }

    var projectedValue: Binding<[Person]> {
        Binding(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }
}

extension URL {
    static var documentsDirectory: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
