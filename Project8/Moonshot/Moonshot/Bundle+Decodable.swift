//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by Krzysztof Kostrzewa on 08/11/2020.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("File \(file) not found")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load contents of \(file)")
        }

        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file)")
        }

        return loaded
    }
}
