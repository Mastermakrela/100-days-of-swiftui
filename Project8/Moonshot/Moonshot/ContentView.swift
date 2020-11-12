//
//  ContentView.swift
//  Moonshot
//
//  Created by Krzysztof Kostrzewa on 08/11/2020.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State private var showingNames = false

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(
                    destination: MissionView(mission: mission, astronatus: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(showingNames ? mission.getCrewNames(astronauts) : mission.formattedLauchDate)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarItems(trailing:
                Button(showingNames ? "Show Dates" : "Show Names") {
                    showingNames.toggle()
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
