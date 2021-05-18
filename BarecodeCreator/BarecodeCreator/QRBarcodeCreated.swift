//
//  QRBarcodeCreated.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
import UIKit
 
struct QRBarcodeCreated: View {
   
    // Input Parameters
    let url: String
    let apiQuery: String
   
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
           
            // Insert ActivityViewController within the window hierarchy in the background
            activityViewController
       
            VStack(spacing: 40) {
               
                Text(url)
                    .font(.headline)
               
                // Show the generated QR barcode image
                qrBarcodeImage(imageUrlString: apiQuery)
               
                Button(action: {
                    // Display the Share interface to Share uiImageOfQRBarcode
                    activityViewController.shareImage(uiImage: uiImageOfQRBarcode)
                }) {
                    HStack {
                        Image(systemName:"square.and.arrow.up")
                            .imageScale(.medium)
                            .font(Font.title.weight(.regular))
                            .foregroundColor(.blue)
                        Text("Share")
                    }
                }
                /*
                 Enable the user to save the created barcode image in the Photos app
                 by adding the following row in Info.plist file:
                    Privacy - Photo Library Additions Usage Description -->
                    BarcodeCreator can store the created barcode image in your Photos app upon your permission.
                 */
            }   // End of VStack
        }   // End of ZStack
    }   // End of body
}
 
 
 
