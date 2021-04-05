//
//  PersonRow.swift
//  MeetThemAll
//
//  Created by Krzysztof Kostrzewa on 05.04.21.
//

import SwiftUI

struct PersonRow: View {
    let person: Person

    var body: some View {
        HStack {
            if let img = person.image {
                Image(uiImage: img)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.trailing)
            }
            Text(person.name)
        }
    }
}

// struct PersonRow_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonRow()
//    }
// }
