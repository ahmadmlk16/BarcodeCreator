//
//  BarcodeAztec.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct BarcodeAztec: View {
   
    @State private var textFieldValue = ""
    @State private var valueEntered = ""
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Aztec barcode is an ISO/IEC 24778:2008 standard. It is designed to have higher accuracy than other barcode symbologies. It can encode up to 3,832 numeric digits, 3,067 alphabetic characters, or 1,914 bytes of data.")) {
                   
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
                                Text("Generate Aztec Barcode")
                            }
                        }
                    }
                }
            }   // End of Form
            .navigationBarTitle(Text("Generate Aztec Barcode"), displayMode: .inline)
           
        }   // End of NavigationView
    }   // End of body
   
    var barcodeGeneration: some View {
        let barcodeImage: UIImage = createBarcode(from: valueEntered, type: "CIAztecCodeGenerator", scaleFactor: 10)!
        return AnyView(
            BarcodeCreated(input: valueEntered, image: barcodeImage)
                .navigationBarTitle(Text("Generated Aztec Barcode"), displayMode: .inline)
        )
    }
}
 
struct BarcodeAztec_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeAztec()
    }
}
 
