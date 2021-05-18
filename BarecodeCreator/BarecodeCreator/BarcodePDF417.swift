//
//  BarcodePDF417.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct BarcodePDF417: View {
       
    @State private var textFieldValue = ""
    @State private var valueEntered = ""
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("PDF417 is a stacked linear barcode format used predominantly in transport, ID cards, and inventory management. PDF stands for Portable Data File. 417 indicates that each pattern in the code consists of 4 bars and spaces in a pattern that is 17 units long.")) {
                   
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
                                Text("Generate PDF417 Barcode")
                            }
                        }
                    }
                }
            }   // End of Form
            .navigationBarTitle(Text("Generate PDF417 Barcode"), displayMode: .inline)
           
        }   // End of NavigationView
    }   // End of body
   
    var barcodeGeneration: some View {
        let barcodeImage: UIImage = createBarcode(from: valueEntered, type: "CIPDF417BarcodeGenerator", scaleFactor: 3)!
        return AnyView(
            BarcodeCreated(input: valueEntered, image: barcodeImage)
                .navigationBarTitle(Text("Generated PDF417 Barcode"), displayMode: .inline)
        )
    }
}
 
struct BarcodePDF417_Previews: PreviewProvider {
    static var previews: some View {
        BarcodePDF417()
    }
}
 
