//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Krzysztof Kostrzewa on 08.04.21.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort

    private var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }

    private var price: String {
        String(repeating: "$", count: resort.price)
    }

    var body: some View {
        Group {
            Text("Size: \(size)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(price)").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: .example)
    }
}
