//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Krzysztof Kostrzewa on 01.04.21.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get { title ?? "Unknown value" }
        set { title = newValue }
    }

    public var wrappedSubtitle: String {
        get { subtitle ?? "Unknown value" }
        set { subtitle = newValue }
    }
}
