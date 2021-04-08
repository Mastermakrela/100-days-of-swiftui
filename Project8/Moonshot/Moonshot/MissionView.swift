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

    func imageHeight(geo: GeometryProxy) -> CGFloat {
        let newheight = geo.size.height + (geo.frame(in: .global).minY - 44)

        guard newheight < geo.size.height else {
            return geo.size.height
        }

        guard newheight > geo.size.height * 0.2 else {
            return geo.size.height * 0.2
        }

        return newheight
    }

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: 0.0) {
                    GeometryReader { imageGeo in
                        VStack(alignment: .center) {
                            Spacer(minLength: 0)

                            Image(mission.image)
                                .resizable()
                                .scaledToFit()

                                .frame(height: imageHeight(geo: imageGeo), alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: imageGeo.size.height)
                    }
                    .frame(height: geo.size.width * 0.7)

                    .padding(.vertical)

                    HStack {
                        Text("Launch Date:")
                        Spacer()
                        Text("\(mission.formattedLauchDate)")
                    }
                    .padding([.horizontal, .top])

                    Text(mission.description)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding()
                    Text(mission.description)
                        .fixedSize(horizontal: false, vertical: true)
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
