//
//  QRBarcodeData.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import SwiftUI
 
// Global dictionary
var dict_ColorName_ColorHex = [String: String]()
 
// Global variable
var uiImageOfQRBarcode = UIImage()
 
/*
 *****************************
 MARK: - Read Colors Data File
 *****************************
 */
public func readColorsDataFile() {
 
    // Obtain URL to the Colors.plist file in the main bundle (project folder)
    let plistFileURL: URL? = Bundle.main.url(forResource: "Colors", withExtension: "plist")
   
    // Instantiate an NSDictionary object and initialize it with the contents of the Colors.plist file.
    let dictionaryFromFile: NSDictionary? = NSDictionary(contentsOf: plistFileURL!)
   
    if let dictionaryForColorsPlistFile = dictionaryFromFile {
       
        // Typecast the created dictionary as Dictionary type and assign it.
        dict_ColorName_ColorHex = dictionaryForColorsPlistFile as! Dictionary
       
    } else {
        // Unable to get the file from the main bundle
        fatalError("Colors.plist file does not exist in the main bundle!")
    }
 
}
 
/*
*******************************
MARK: - Obtain QR Barcode Image
*******************************
*/
public func qrBarcodeImage(imageUrlString: String) -> Image {
   
    // Local Variables
    var errorInReadingImageData: NSError?
    var imageData: Data?
   
    if let imageUrl = URL(string: imageUrlString) {
       
        do {
            // Try to get the image data from imageUrl
            imageData = try Data(contentsOf: imageUrl, options: NSData.ReadingOptions.mappedIfSafe)
           
        } catch let error as NSError {
            errorInReadingImageData = error
            imageData = nil
        }
       
        // Unwrap imageData to see if it has a value
        if let imageDataObtained = imageData {
           
            // Create a UIImage object from imageDataObtained
            let uiImage = UIImage(data: imageDataObtained)
           
            // Unwrap uiImage to see if it has a value
            if let imageObtained = uiImage {
                /*
                 *******************************************************
                 Store QR barcode's UIImage version into global variable
                 uiImageOfBarcode to use in the Share Activity code.
                 *******************************************************
                 */
                uiImageOfQRBarcode = imageObtained
               
                // Image is successfully obtained
                return Image(uiImage: imageObtained)
            } else {
                return Image("ImageUnavailable")
            }
        } else {
            if errorInReadingImageData != nil {
                // Take no action since image may not be available
            }
            // When there is no image available, display ImageUnavailable.png
            // Do NOT include file extension.
            return Image("ImageUnavailable")
        }
       
    } else {
        return Image("ImageUnavailable")
    }
   
}
 
 
