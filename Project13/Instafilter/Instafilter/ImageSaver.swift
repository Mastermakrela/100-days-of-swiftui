//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Krzysztof Kostrzewa on 01.04.21.
//

import CoreImage
import Foundation
import SwiftUI

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_: UIImage, didFinishSavingWithError error: Error?, contextInfo _: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
