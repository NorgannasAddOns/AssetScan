//
//  ViewController.swift
//  AssetScan
//
//  Created by Kenneth Allan on 24/11/2015.
//  Copyright © 2015 Norganna's AddOns Pty Ltd. All rights reserved.
//

import UIKit
import ZBarSDK

extension ZBarSymbolSet: SequenceType {
    public func generate() -> NSFastGenerator {
        return NSFastGenerator(self)
    }
}

class ViewController: ZBarReaderViewController, ZBarReaderDelegate {
    var capturing: Bool = true
    var overview: Overview! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.cameraFlashMode = UIImagePickerControllerCameraFlashMode.Off
        /*
        ZBAR_NONE        =      0,  /**< no symbol decoded */
        ZBAR_PARTIAL     =      1,  /**< intermediate status */
        ZBAR_EAN2        =      2,  /**< GS1 2-digit add-on */
        ZBAR_EAN5        =      5,  /**< GS1 5-digit add-on */
        ZBAR_EAN8        =      8,  /**< EAN-8 */
        ZBAR_UPCE        =      9,  /**< UPC-E */
        ZBAR_ISBN10      =     10,  /**< ISBN-10 (from EAN-13). @since 0.4 */
        ZBAR_UPCA        =     12,  /**< UPC-A */
        ZBAR_EAN13       =     13,  /**< EAN-13 */
        ZBAR_ISBN13      =     14,  /**< ISBN-13 (from EAN-13). @since 0.4 */
        ZBAR_COMPOSITE   =     15,  /**< EAN/UPC composite */
        ZBAR_I25         =     25,  /**< Interleaved 2 of 5. @since 0.4 */
        ZBAR_DATABAR     =     34,  /**< GS1 DataBar (RSS). @since 0.11 */
        ZBAR_DATABAR_EXP =     35,  /**< GS1 DataBar Expanded. @since 0.11 */
        ZBAR_CODABAR     =     38,  /**< Codabar. @since 0.11 */
        ZBAR_CODE39      =     39,  /**< Code 39. @since 0.4 */
        ZBAR_PDF417      =     57,  /**< PDF417. @since 0.6 */
        ZBAR_QRCODE      =     64,  /**< QR Code. @since 0.10 */
        ZBAR_CODE93      =     93,  /**< Code 93. @since 0.11 */
        ZBAR_CODE128     =    128,  /**< Code 128 */
        */
        self.scanner.setSymbology(ZBAR_NONE, config: ZBAR_CFG_X_DENSITY, to: 1)
        self.scanner.setSymbology(ZBAR_NONE, config: ZBAR_CFG_Y_DENSITY, to: 1)
        // */
        self.scanner.setSymbology(ZBAR_QRCODE, config: ZBAR_CFG_ENABLE, to: 1)
        self.scanner.setSymbology(ZBAR_QRCODE, config: ZBAR_CFG_ASCII, to: 1)
        
        self.scanner.setSymbology(ZBAR_CODE39, config: ZBAR_CFG_ENABLE, to: 1)
        self.scanner.setSymbology(ZBAR_CODE39, config: ZBAR_CFG_ASCII, to: 1)
        
        self.scanner.setSymbology(ZBAR_CODE128, config: ZBAR_CFG_ENABLE, to: 1)
        self.scanner.setSymbology(ZBAR_CODE128, config: ZBAR_CFG_ASCII, to: 1)
        
        self.scanner.setSymbology(ZBAR_PDF417, config: ZBAR_CFG_ENABLE, to: 1)
        self.scanner.setSymbology(ZBAR_PDF417, config: ZBAR_CFG_ASCII, to: 1)
        
        self.scanner.setSymbology(ZBAR_DATABAR, config: ZBAR_CFG_ENABLE, to: 1)
        self.scanner.setSymbology(ZBAR_DATABAR, config: ZBAR_CFG_ASCII, to: 1)
        
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "Overview", bundle: bundle)
        self.overview = nib.instantiateWithOwner(self, options: nil)[0] as! Overview
        self.overview.frame = view.bounds
        self.overview.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.overview.backgroundColor = UIColor.clearColor()
        self.overview.parent = self
        
        self.cameraOverlayView = self.overview as UIView
        self.tracksSymbols = true
        
        self.showsZBarControls = false
        self.readerView.showsFPS = true
        self.readerView.trackingColor = UIColor.redColor()
        self.readerView.allowsPinchZoom = true
        self.readerView.maxZoom = 8
        self.readerView.scanCrop = CGRect(x: 0.05, y: 0.05, width: 0.95, height: 0.95)
        self.enableCache = false
        
        self.readerDelegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if (!capturing || self.scanner.pauseScan) {
            return
        }

        objc_sync_enter(self.scanner);
            let results: ZBarSymbolSet = info[ZBarReaderControllerResults] as! ZBarSymbolSet
        //    let r2: ZBarSymbolSet = ZBarSymbolSet(symbolSet: results.zbarSymbolSet)
        
        //    print("----")
            var output = "";
            for s in results {
                let symbol = s as! ZBarSymbol
            //    print(ZBarSymbol.nameForType(symbol.type))
            //    print(symbol.data)
                if (output == "") {
                    output = symbol.data
                } else {
                    output = output + ", " + symbol.data
                }
            }

        if (output != "") {
            overview.setBarcode(output)
        }
        
        objc_sync_exit(self.scanner);
    }
    
    
    
}
