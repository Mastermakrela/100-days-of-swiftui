//
//  DoubleRangeSelector.swift
//  MultiPlaying
//
//  Created by Krzysztof Kostrzewa on 04/11/2020.
//

import SwiftUI

struct DoubleRangeSelector: View {
    let xRange: ClosedRange<Int>
    let yRange: ClosedRange<Int>
    @Binding var selection: (Int, Int)

    var optionsCount: Int { (xRange.count + 1) * (yRange.count + 1) }
    var columns: [GridItem] { .init(repeating: GridItem(.flexible(), spacing: 4), count: xRange.count + 1) }

    var body: some View {
        LazyVGrid(columns: columns, alignment: .center, spacing: 4) {
            ForEach(0 ..< optionsCount) { idx -> AnyView in
                let pos = (idx / (xRange.count + 1), idx % (xRange.count + 1))

                return AnyView(Group {
                    switch pos {
                    case (0, 0):
                        Rectangle().aspectRatio(contentMode: .fit).opacity(0)

                    case (0, 1):
                        Text("\(xRange.min()!)")

                    case (0, xRange.max()!):
                        Text("\(xRange.max()!)")

                    case (1, 0):
                        Text("\(yRange.min()!)")

                    case (yRange.max()!, 0):
                        Text("\(yRange.max()!)")

                    case (0, _), (_, 0):
                        Rectangle().aspectRatio(contentMode: .fit).opacity(0)

                    default:
                        RoundedRectangle(cornerRadius: 5)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(
                                pos.0 <= selection.0 && pos.1 <= selection.1
                                    ? Color.blue.opacity(0.5)
                                    : Color.primary.opacity(0.5))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.primary.opacity(0.8), lineWidth: 1))
                            .onTapGesture {
                                selection = pos
                            }
                    }
                })
            }
        }
        .animation(.easeInOut(duration: 0.3))
    }
}

struct DoubleRangeSelector_Previews: PreviewProvider {
    @State static var s = (1, 1)
    static var previews: some View {
        DoubleRangeSelector(xRange: 1 ... 5, yRange: 1 ... 5, selection: $s)
            .padding()
    }
}
