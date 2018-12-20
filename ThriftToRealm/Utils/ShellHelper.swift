//
//  ShellHelper.swift
//  TestCommandLinesApps
//
//  Created by Alexandr on 9/9/17.
//  Copyright © 2017 Alexandr. All rights reserved.
//

import Foundation


//MARK: HELPERS

@discardableResult
func shell(_ args: String...) -> Int32 {
    
    let task        = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments  = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

@discardableResult
func shellBin(_ args: String...) -> Int32 {
    
    let task        = Process()
    task.launchPath = "/usr/local/bin"
    task.arguments  = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}

