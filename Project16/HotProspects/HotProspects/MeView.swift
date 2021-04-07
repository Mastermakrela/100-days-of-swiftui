//
//  MeView.swift
//  HotProspects
//
//  Created by Krzysztof Kostrzewa on 06.04.21.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    @State private var name = "Anonumous"
    @State private var emailAddress = "you@yousite.com"

    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)

                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])

                Image(uiImage: generateQRCode(from: "\(name)\n\(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)

                Spacer()
            }
            .navigationTitle("Your Code")
        }
    }

    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgimg = context.createCGImage(outputImage, from: outputImage.extent)
        {
            return UIImage(cgImage: cgimg)
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
