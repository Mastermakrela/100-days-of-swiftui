//
//  RatingView.swift
//  Bookworm
//
//  Created by Krzysztof Kostrzewa on 22/11/2020.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var label = ""

    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }

            ForEach(1 ..< maxRating + 1) { num in
                image(for: num)
                    .foregroundColor(num > rating ? offColor : onColor)
                    .accessibility(label: Text("\(num == 1 ? "1 star" : "\(num) stars")"))
                    .accessibility(removeTraits: .isImage)
                    .accessibility(addTraits: num > self.rating ? .isButton : [.isButton, .isSelected])

                    .onTapGesture {
                        self.rating = num
                    }
            }
        }
    }

    private func image(for number: Int) -> Image {
        (number > rating ? offImage ?? onImage : onImage)
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(3))
    }
}
