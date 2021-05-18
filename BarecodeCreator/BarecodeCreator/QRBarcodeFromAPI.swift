//
//  QRBarcodeFromAPI.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct QRBarcodeFromAPI: View {
           
    @State private var textFieldValue = ""
    @State private var valueEntered = ""
   
    @State private var selectedSizeIndex = 2
    var barcodeSizes = ["100", "150", "200", "250", "300"]
   
    @State private var selectedFGColorIndex = 5
    var foregroundColors = ["Black", "Blue", "Brown", "Crimson", "Dark Blue", "Dark Green", "Dark Red", "Indigo", "Maroon", "Navy Blue", "Purple"]
   
    @State private var selectedBGColorIndex = 5
    var backgroundColors = ["Alice Blue", "Azure", "Beige", "Honey Dew", "Ivory", "Linen", "Mint Cream", "Old Lace", "Papaya Whip", "Sea Shell", "White"]
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Barcode URL")) {
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
                       
                }
                Section(header: Text("Barcode Size")) {
                    Picker("Barcode Size", selection: $selectedSizeIndex) {
                        ForEach(0 ..< barcodeSizes.count, id: \.self) {
                            Text(self.barcodeSizes[$0]).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Barcode Foreground Color")) {
                    Picker("Pick", selection: $selectedFGColorIndex) {
                        ForEach(0 ..< foregroundColors.count, id: \.self) {
                            Text(self.foregroundColors[$0]).tag($0)
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
                Section(header: Text("Barcode Background Color")) {
                    Picker("Pick", selection: $selectedBGColorIndex) {
                        ForEach(0 ..< backgroundColors.count, id: \.self) {
                            Text(self.backgroundColors[$0]).tag($0)
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
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
       
        let url = valueEntered
        let qrCodeSize = barcodeSizes[selectedSizeIndex]
       
        let selectedFgColorName = foregroundColors[selectedFGColorIndex]
        let fgColorHexCode = dict_ColorName_ColorHex[selectedFgColorName]
       
        let selectedBgColorName = backgroundColors[selectedBGColorIndex]
        let bgColorHexCode = dict_ColorName_ColorHex[selectedBgColorName]
       
        let query = "https://api.qrserver.com/v1/create-qr-code/?data=\(url)&size=\(qrCodeSize)x\(qrCodeSize)&color=\(fgColorHexCode!)&bgcolor=\(bgColorHexCode!)&format=png"
       
        return AnyView(
            QRBarcodeCreated(url: valueEntered, apiQuery: query)
                .navigationBarTitle(Text("Generated QR Barcode"), displayMode: .inline)
        )
    }
}
 
 
struct QRBarcodeFromAPI_Previews: PreviewProvider {
    static var previews: some View {
        QRBarcodeFromAPI()
    }
}
 
