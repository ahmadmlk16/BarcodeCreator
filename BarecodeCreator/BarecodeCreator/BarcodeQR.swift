//
//  BarcodeQR.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct BarcodeQR: View {
   
    @State private var textFieldValue = ""
    @State private var valueEntered = ""
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("QR (Quick Response) barcode allows to encode over 4000 characters. In practice, QR codes often contain data for a locator, identifier, or tracker that points to a website or application.")) {
                   
                    HStack {
                        TextField("Enter input to generate barcode", text: $textFieldValue,
                            onCommit: {
                                // Record entered value after Return key is pressed
                                self.valueEntered = self.textFieldValue
                            }
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                       
                        // Button to clear the text field
                        Button(action: {
                            self.textFieldValue = ""
                            self.valueEntered = ""
                        }) {
                            Image(systemName: "multiply.circle")
                                .imageScale(.medium)
                                .font(Font.title.weight(.regular))
                        }
                    }   // End of HStack
                    .padding(.horizontal)
                       
                }   // End of HStack
               
                if !valueEntered.isEmpty {
                    Section(header: Text("Generate")) {
                        NavigationLink(destination: barcodeGeneration) {
                            HStack {
                                Image(systemName: "gear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Generate QR Barcode")
                            }
                        }
                    }
                }
            }   // End of Form
            .navigationBarTitle(Text("Generate QR Barcode"), displayMode: .inline)
           
        }   // End of NavigationView
    }   // End of body
   
    var barcodeGeneration: some View {
        let barcodeImage: UIImage = createBarcode(from: valueEntered, type: "CIQRCodeGenerator", scaleFactor: 8)!
        return AnyView(
            BarcodeCreated(input: valueEntered, image: barcodeImage)
                .navigationBarTitle(Text("Generated QR Barcode"), displayMode: .inline)
        )
    }
}
 
struct BarcodeQR_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeQR()
    }
}
 
 
