//
//  EditView.swift
//  BucketList
//
//  Created by Krzysztof Kostrzewa on 01.04.21.
//

import Combine
import MapKit
import SwiftUI

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation

    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()

    @State private var placesCancellable: AnyCancellable?

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }

                Section(header: Text("Nearby…")) {
                    switch loadingState {
                    case .loaded:
                        List(pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ") +
                                Text(page.description)
                                .italic()
                        }

                    case .loading:
                        Text("Loading…")

                    default:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Edit place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
            .onAppear(perform: fetchNearbyPlaces)
        }
    }

    func fetchNearbyPlaces() {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        placesCancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Result.self, decoder: JSONDecoder())
            .map(\.query.pages.values)
            .map { [Page]($0).sorted() }
            .sink { _ in }
        receiveValue: {
            loadingState = .loaded
            pages = $0
        }
    }

    enum LoadingState {
        case loading, loaded, failed
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
