//
//  ShareActivity.swift
//  BarecodeCreator
//
//  Created by cs3714 on 2/24/20.
//  Copyright © 2020 AhmadMalik. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
 
let activityViewController = ActivityViewControllerRepresentable()
 
class ActivityViewController : UIViewController {
 
    var uiImage: UIImage!
 
    @objc func shareImage() {
        let activityViewController = UIActivityViewController(activityItems: [uiImage!], applicationActivities: nil)
        activityViewController.excludedActivityTypes =  [
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.addToReadingList
        ]
        present(activityViewController, animated: true, completion: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
    }
}
 
struct ActivityViewControllerRepresentable: UIViewControllerRepresentable {
 
    let activityViewController = ActivityViewController()
 
    func makeUIViewController(context: Context) -> ActivityViewController {
        activityViewController
    }
    func updateUIViewController(_ uiViewController: ActivityViewController, context: Context) {
        // Unused
    }
    func shareImage(uiImage: UIImage) {
        activityViewController.uiImage = uiImage
        activityViewController.shareImage()
    }
}
 
