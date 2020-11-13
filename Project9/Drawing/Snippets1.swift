//
//  SnippetsDay1.swift
//  Drawing
//
//  Created by Krzysztof Kostrzewa on 12/11/2020.
//

import SwiftUI

// var body: some View {
//    Arc(startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
//        .strokeBorder(Color.blue, lineWidth: 10)
// }

struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    var insetAmount: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: rect.width / 2 - insetAmount,
            startAngle: modifiedStart,
            endAngle: modifiedEnd,
            clockwise: !clockwise
        )

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

// Path { path in
//    path.addLines([
//        .init(x: 2, y: 1),
//        .init(x: 1, y: 0),
//        .init(x: 0, y: 1),
//        .init(x: 1, y: 2),
//        .init(x: 3, y: 0),
//        .init(x: 4, y: 1),
//        .init(x: 3, y: 2),
//        .init(x: 2, y: 1)
//    ])
// }
// .trim(from: 0.25, to: 1.0)
// .scale(50, anchor: .topLeading)
// .stroke(Color.black, lineWidth: 3)
