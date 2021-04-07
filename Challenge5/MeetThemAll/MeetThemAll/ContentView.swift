//
//  ContentView.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 03.04.21.
//

import SwiftUI

struct ContentView: View {
    @State private var showAddSheet = false
    @Document("people.json") var people: [Person]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(people) { person in
                        NavigationLink(
                            destination: PersonPage(person: person),
                            label: {
                                PersonRow(person: person)
                            }
                        )
                    }
                }

                Button("Add new Person") {
                    showAddSheet.toggle()
                }
            }
            .navigationTitle("People you've met")
        }
        .sheet(isPresented: $showAddSheet, content: {
            AddPersonView(people: $people)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
