//
//  ContentView.swift
//  Project3
//
//  Created by Krzysztof Kostrzewa on 29/10/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")

//            .modifier(BlueTitle())
            .blueTitle()

            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

public extension View {
    func blueTitle() -> some View {
        modifier(BlueTitle())
    }
}
