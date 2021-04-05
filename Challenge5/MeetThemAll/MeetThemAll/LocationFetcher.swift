//
//  LocationFetcher.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 05.04.21.
//

import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
    }

    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }

    deinit {
        print("LocationFetcher destroyed")
    }
}
