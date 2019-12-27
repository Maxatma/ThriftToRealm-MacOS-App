//
//  FileManagerHelper.swift
//
//
//  Created by Alexander Zaporozhchenko on 9/29/17.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import Foundation


extension FileManager {
    
    func cleanCopyItem(at tempLocalUrl: URL, to localUrl: URL) {
        if FileManager.default.fileExists(atPath: localUrl.path) {
            try! FileManager.default.removeItem(at: localUrl)
        }
        try! FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
    }
}

