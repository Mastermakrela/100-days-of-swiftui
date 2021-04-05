//
//  MapView.swift
//  BucketList
//
//  Created by Krzysztof Kostrzewa on 05.04.21.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    let annotation: MKPointAnnotation

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.addAnnotation(annotation)
        mapView.centerCoordinate = annotation.coordinate
        return mapView
    }

    func updateUIView(_: MKMapView, context _: Context) {}

    // MARK: - Coordinator

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"

            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(annotation: MKPointAnnotation.example)
    }
}

extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        return annotation
    }
}
