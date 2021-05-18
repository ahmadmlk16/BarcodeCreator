//
//  BarcodeCode128.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct BarcodeCode128: View {
           
    @State private var textFieldValue = ""
    @State private var valueEntered = ""
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Code 128 barcode is a high-density linear barcode symbology defined in ISO/IEC 15417:2007. It is used for alphanumeric or numeric-only barcodes. It can encode all 128 characters of ASCII and, by use of an extension symbol (FNC4), the Latin-1 characters defined in ISO/IEC 8859-1.")) {
                   
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
                        
                }   // End of Section
               
                if !valueEntered.isEmpty {
                    Section(header: Text("Generate")) {
                        NavigationLink(destination: barcodeGeneration) {
                            HStack {
                                Image(systemName: "gear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                                    .foregroundColor(.blue)
                                Text("Generate Code 128 Barcode")
                            }
                        }
                    }
                }
               
            }   // End of Form
            .navigationBarTitle(Text("Generate Code 128 Barcode"), displayMode: .inline)
           
        }   // End of NavigationView
    }   // End of body
   
    var barcodeGeneration: some View {
        let barcodeImage: UIImage = createBarcode(from: valueEntered, type: "CICode128BarcodeGenerator", scaleFactor: 3)!
        return AnyView(
            BarcodeCreated(input: valueEntered, image: barcodeImage)
                .navigationBarTitle(Text("Generated Code 128 Barcode"), displayMode: .inline)
        )
    }
}
 
struct BarcodeCode128_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeCode128()
    }
}
