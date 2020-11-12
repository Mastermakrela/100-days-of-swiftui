//
//  AstronautView.swift
//  Moonshot
//
//  Created by Krzysztof Kostrzewa on 08/11/2020.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)

                    Group {
                        Text(astronaut.description)

                        Text("Flew in following missions:")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ForEach(missions) { mission in
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .frame(width: 44, height: 44)

                                VStack(alignment: .leading) {
                                    Text("\(mission.displayName)")
                                        .fontWeight(.medium)
                                    Text("\(mission.formattedLauchDate)")
                                }
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }

    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        let allMissions: [Mission] = Bundle.main.decode("missions.json")

        missions = allMissions.filter {
            $0.crew.map(\.name).contains(astronaut.id)
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts.first!)
    }
}
