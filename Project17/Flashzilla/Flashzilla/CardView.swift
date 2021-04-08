//
//  CardView.swift
//  Flashzilla
//
//  Created by Krzysztof Kostrzewa on 07.04.21.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    let card: Card
    var removal: (() -> Void)?

    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                .fill(
                    differentiateWithoutColor
                        ? Color.white
                        : Color.white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background(
                    differentiateWithoutColor
                        ? nil
                        : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(offset.width > 0 ? Color.green : Color.red)
                )
                .shadow(radius: 10)

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 3)))
        .offset(x: offset.width * 3, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))

        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring())
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }

                        self.removal?()
                    } else {
                        offset = .zero
                    }
                }
        )

        .accessibility(addTraits: .isButton)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: .example)
    }
}
