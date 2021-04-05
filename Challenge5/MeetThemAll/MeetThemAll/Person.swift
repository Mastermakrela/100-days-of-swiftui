//
//  Person.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 04.04.21.
//

import MapKit
import SwiftUI

struct Person: Codable, Identifiable {
    var id = UUID()
    var name: String
    var image: UIImage?
    var location: CLLocationCoordinate2D

    private let imageName: String

    var imagePath: URL {
        URL.documentsDirectory!.appendingPathComponent(imageName)
    }

    init?(name: String, image: UIImage, location: CLLocationCoordinate2D) {
        id = UUID()
        self.name = name
        self.image = image
        self.location = location
        imageName = "\(id).jpg"

        guard let jpegData = image.jpegData(compressionQuality: 0.8) else { return nil }
        try? jpegData.write(to: imagePath, options: [.atomicWrite, .completeFileProtection])
    }
}

// MARK: - Codable

extension Person {
    enum CodingKeys: CodingKey {
        case id, name, imageName, lat, lon
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(imageName, forKey: .imageName)
        try container.encode(location.latitude, forKey: .lat)
        try container.encode(location.longitude, forKey: .lon)
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        imageName = try container.decode(String.self, forKey: .imageName)
        let lat = try container.decode(Double.self, forKey: .lat)
        let lon = try container.decode(Double.self, forKey: .lon)
        location = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))

        if let imageData = try? Data(contentsOf: imagePath) {
            image = UIImage(data: imageData)
        }
    }
}
