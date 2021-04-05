//
//  PersonPage.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 05.04.21.
//

import MapKit
import SwiftUI

struct PersonPage: View {
    let person: Person

    var annotation: MKPointAnnotation {
        let a = MKPointAnnotation()
        a.coordinate = person.location
        return a
    }

    var body: some View {
        VStack {
            Image(uiImage: person.image!)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding()

            MapView(annotation: annotation)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .padding()
        }
        .navigationTitle(person.name)
    }
}

// struct PersonPage_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonPage()
//    }
// }
