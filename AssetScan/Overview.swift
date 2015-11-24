//
//  Overview.swift
//  LadBar
//
//  Created by Kenneth Allan on 23/11/2015.
//  Copyright © 2015 Kenneth Allan. All rights reserved.
//

import UIKit

@IBDesignable class Overview: UIView {
    @IBOutlet weak var BarcodeLabel: UILabel!
    @IBOutlet weak var ScannerButton: UISwitch!
    @IBOutlet weak var LightButton: UISwitch!
    @IBOutlet weak var CopyCode: UIButton!
    @IBOutlet weak var OpenURL: UIButton!
    
    var parent: ViewController!
    
    @IBAction func ScannerToggled(sender: UISwitch) {
        parent.capturing = sender.on
        #if ZBAR_PAUSIBLE
            parent.scanner.pauseScan = !sender.on
        #endif
        
        if (sender.on) {
            LightToggled(LightButton)
        } else {
            LightToggled(sender)
        }
    }
    
    @IBAction func LightToggled(sender: UISwitch) {
        parent.cameraFlashMode = sender.on ? UIImagePickerControllerCameraFlashMode.On : UIImagePickerControllerCameraFlashMode.Off
    }
    
    @IBAction func CopyClicked(sender: UIButton) {
        UIPasteboard.generalPasteboard().string = BarcodeLabel.text
    }
    
    @IBAction func OpenClicked(sender: UIButton) {
        if let checkURL = NSURL(string: BarcodeLabel.text!) {
            if UIApplication.sharedApplication().openURL(checkURL) {
                print("url successfully opened")
            }
        } else {
            print("invalid url")
        }

    }
    
    @IBAction func ZoomClicked(sender: UIButton) {
        if (parent.readerView.zoom >= 3) {
            parent.readerView.zoom = 1
        }
        else if (parent.readerView.zoom >= 2.5) {
            parent.readerView.zoom = 3
        }
        else if (parent.readerView.zoom >= 2) {
            parent.readerView.zoom = 2.5
        }
        else if (parent.readerView.zoom >= 1.75) {
            parent.readerView.zoom = 2
        }
        else if (parent.readerView.zoom >= 1.5) {
            parent.readerView.zoom = 1.75
        }
        else if (parent.readerView.zoom >= 1.35) {
            parent.readerView.zoom = 1.5
        }
        else if (parent.readerView.zoom >= 1.25) {
            parent.readerView.zoom = 1.35
        }
        else {
            parent.readerView.zoom = 1.25
        }
    }

    func setBarcode(text: String) {
        BarcodeLabel.text = text
    }
    
}
