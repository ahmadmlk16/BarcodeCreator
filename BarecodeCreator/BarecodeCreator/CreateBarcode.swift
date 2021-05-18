//
//  CreateBarcode.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import UIKit
import Foundation
 
/*
 Core Image (CI) framework is an image processing and analysis technology
 designed to provide near real-time processing for still and video images.
 
 Core Graphics (CG) framework is based on the Quartz advanced drawing engine.
 It provides low-level, lightweight 2D rendering with unmatched output fidelity.
 */
 
public func createBarcode(from stringValue: String, type barcodeType: String, scaleFactor scale: CGFloat) -> UIImage? {
 
    let data = stringValue.data(using: String.Encoding.ascii)
    /*
     code128    = "CICode128BarcodeGenerator"
     pdf417     = "CIPDF417BarcodeGenerator"
     aztec      = "CIAztecCodeGenerator"
     qr         = "CIQRCodeGenerator"
 
     Code 128 is a high-density linear barcode symbology defined in ISO/IEC 15417:2007.
     It is used for alphanumeric or numeric-only barcodes. It can encode all 128 characters of ASCII and,
     by use of an extension symbol (FNC4), the Latin-1 characters defined in ISO/IEC 8859-1.
 
     PDF417 is a stacked linear barcode symbol format used predominantly in transport, ID cards, and
     inventory management. Each pattern in the code comprises 4 bars and spaces, 17 units long.
 
     Aztec code is a format of 2D barcode published as ISO/IEC 24778:2008 standard.
     It encodes data in concentric square rings around a central bullseye pattern.
 
     Quick Response (QR) codes can encode text, vCard contact information, or URLs.
     */
    if let ciFilter = CIFilter(name: barcodeType) {
       
        ciFilter.setDefaults()
        ciFilter.setValue(data, forKey: "inputMessage")
       
        // Set image scale factor for x and y coordinates
        let factorByWhichToScale = CGAffineTransform(scaleX: scale, y: scale)
 
        // If ciFilter.outputImage has a value, scale it by a factor of the given value 'scale'
        if let output = ciFilter.outputImage?.transformed(by: factorByWhichToScale) {
           
            let ciContext: CIContext = CIContext.init(options: nil)
            let cgImageFromOutput: CGImage = ciContext.createCGImage(output, from: output.extent)!
            let rawImage: UIImage = UIImage.init(cgImage: cgImageFromOutput)
            let cgImage: CGImage = (rawImage.cgImage)!
           
            let cropZone = CGRect(x: 0, y: 0, width: Int(rawImage.size.width), height: Int(rawImage.size.height))
            let cWidth: size_t  = size_t(cropZone.size.width)
            let cHeight: size_t  = size_t(cropZone.size.height)
            let bitsPerComponent: size_t = cgImage.bitsPerComponent
            let bytesPerRow = (cgImage.bytesPerRow) / (cgImage.width * cWidth)
 
            let cgContext = CGContext(data: nil, width: cWidth, height: cHeight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: cgImage.bitmapInfo.rawValue)!
 
            cgContext.draw(cgImage, in: cropZone)
 
            let cgImageObtained: CGImage  = cgContext.makeImage()!
            let barcodeImageCreated = UIImage(cgImage: cgImageObtained)
 
            return barcodeImageCreated
        }
    }
    return nil
}
 
 
