//
//  BarcodeCreated.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct BarcodeCreated: View {
   
    // Input Parameters
    let input: String
    let image: UIImage
 
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
           
            // Insert ActivityViewController within the window hierarchy in the background
            activityViewController
       
            VStack(spacing: 40) {
                Text(input)
                    .font(.headline)
                    .padding(.horizontal)
               
                // Show the generated barcode image
                Image(uiImage: image)
               
                Button(action: {
                    // Display the Share Interface to Share UImage of Barcode
                    activityViewController.shareImage(uiImage: self.image)
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
 
 
