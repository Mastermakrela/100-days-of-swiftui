//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Krzysztof Kostrzewa on 23/11/2020.
//
//

import CoreData
import Foundation

public extension Movie {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Movie> {
        NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged var title: String?
    @NSManaged var director: String?
    @NSManaged var year: Int16
}

extension Movie: Identifiable {}
