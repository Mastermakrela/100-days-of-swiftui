//
//  MissionView.swift
//  Moonshot
//
//  Created by Krzysztof Kostrzewa on 08/11/2020.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission

    let astronauts: [CrewMember]

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                        .padding(.top)

                    HStack {
                        Text("Launch Date:")
                        Spacer()
                        Text("\(mission.formattedLauchDate)")
                    }
                    .padding([.horizontal, .top])

                    Text(mission.description)
                        .padding()

                    ForEach(astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)

                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }

                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }

    init(mission: Mission, astronatus: [Astronaut]) {
        self.mission = mission

        astronauts = mission.crew
            .map { member in (member.role, astronatus.first { $0.id == member.name }) }
            .filter { $0.1 != nil }
            .map { ($0.0, $0.1!) }
            .map { CrewMember(role: $0.0, astronaut: $0.1) }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions.first!, astronatus: astronauts)
    }
}

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}
