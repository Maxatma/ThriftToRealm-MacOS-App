//
//  ViewController.swift
//  ThriftToRealm
//
//  Created by Alexander Zaporozhchenko on 10/16/18.
//  Copyright © 2018 Aleksandr Zaporozhchenko. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    
    @IBOutlet weak var thriftDestinationTF: NSTextField!
    @IBOutlet weak var generatedFilesDestinationTF: NSTextField!
    @IBOutlet weak var prefix: NSTextField!
    
    private var fileURL: URL?
    private var destinationURL: URL?
    
    @IBAction func importFile(_ sender: Any) {
        
        //TODO: MAKE avaible selection from distant URL
        
        let picker                     = NSOpenPanel()
        picker.allowsMultipleSelection = false
        picker.canChooseDirectories    = false
        picker.canChooseFiles          = true
        picker.runModal()
        
        guard let fileURL               = picker.url else { return }
        thriftDestinationTF.stringValue = fileURL.absoluteString
        self.fileURL                    = fileURL
    }
    
    @IBAction func chooseDestination(_ sender: Any) {
        let picker                     = NSOpenPanel()
        picker.allowsMultipleSelection = false
        picker.canChooseDirectories    = true
        picker.canChooseFiles          = false
        picker.canCreateDirectories    = true
        picker.runModal()
        
        guard let directoryURL = picker.url else { return }
        generatedFilesDestinationTF.stringValue = directoryURL.absoluteString
        self.destinationURL = directoryURL
    }
    
    @IBAction func generate(_ sender: Any) {
        guard let fileURL = self.fileURL, let destinationURL = self.destinationURL else { return }
        let fileCreator = FileCreator(destinationURL: destinationURL)
        fileCreator.createFilesWith(thriftFileURL: fileURL, prefix: prefix.stringValue)
    }
}

