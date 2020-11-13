//
//  ContentView.swift
//  Drawing
//
//  Created by Krzysztof Kostrzewa on 12/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var lineWidth: CGFloat = 5

    var body: some View {
        VStack {
            Arrow()
                .stroke(lineWidth: lineWidth)
                .padding()

            Slider(value: $lineWidth, in: 1 ... 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Arrow: Shape {
//    public var animatableData: AnimatablePair<Double, Double> {
//        get {
//            AnimatablePair(Double(rows), Double(columns))
//        }
//
//        set {
//            rows = Int(newValue.first)
//            columns = Int(newValue.second)
//        }
//    }

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX * 1.5, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}
