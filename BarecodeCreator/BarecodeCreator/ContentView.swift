//
//  ContentView.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import SwiftUI
 
struct ContentView: View {
 
    var body: some View {
        /*
         A barcode is a machine-readable optical label containing
         information about the item to which it is attached.
         */
        TabView {
            BarcodeCode128()
                .tabItem {
                    Image(systemName: "barcode")
                    Text("Code 128")
                }
            BarcodePDF417()
                .tabItem {
                    Image(systemName: "barcode")
                    Text("PDF417")
                }
            BarcodeAztec()
                .tabItem {
                    Image(systemName: "barcode")
                    Text("Aztec")
                }
            BarcodeQR()
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("QR Code")
                }
            QRBarcodeFromAPI()
                .tabItem {
                    Image(systemName: "qrcode")
                    Text("QR Code API")
                }
           
        }   // End of TabView
        .font(.headline)
        .imageScale(.large)
        .font(Font.title.weight(.regular))
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 
