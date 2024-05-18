//
//  SVGImgProcessor.swift
//  DataWowChallenge
//
//  Created by Chace Teera on 18/5/2567 BE.
//

import Kingfisher
import SVGKit

// MARK: - how can downoad SVG image url with kingfisher - https://github.com/onevcat/Kingfisher/issues/1225#issuecomment-692534266

public struct SVGImgProcessor: ImageProcessor {
    
    public var identifier: String = "com.chaceteera.DataWowChallenge"
    
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            return image
        case .data(let data):
            let imsvg = SVGKImage(data: data)
            return imsvg?.uiImage
        }
    }
}
