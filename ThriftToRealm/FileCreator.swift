//
//  FileCreator.swift
//  ThriftToRealm
//
//  Created by Alexander Zaporozhchenko on 10/17/18.
//  Copyright © 2018 Aleksandr Zaporozhchenko. All rights reserved.
//

import Foundation
import ThriftConvertor


final class FileCreator {
    
    private let destinationURL: URL
    
    
    private struct FolderConstants {
        static let Base    = "Base"
        static let API     = "API"
        static let Realm   = "Realm"
        static let Mappers = "Mappers"
    }
    
    init(destinationURL: URL) {
        self.destinationURL = destinationURL
    }
    
    func createFilesWith(thriftFileURL fileURL: URL,
                         prefix: String)  {
        
        let text         = try! String(contentsOf: fileURL)
        let converter    = CodeConverter(prefix: prefix, exceptionNames: [])
        
        let realmClasses = converter.createRealmClasses(thriftText: text)
        create(files: realmClasses, directory: FolderConstants.Realm)
        
        let mappers      = converter.createMapperClasses(thriftText: text)
        create(files: mappers, directory: FolderConstants.Mappers)
        
        let bases        = converter.createBaseClasses()
        create(files: bases, directory: FolderConstants.Base)
        
        createBasicThriftGeneratedFiles(fileURL: fileURL)
    }
    
    private func create(files: [ContentFile], directory: String) {
        let directoryURL = destinationURL.appendingPathComponent(directory)
        
        try! FileManager.default.createDirectory(at: directoryURL,
                                                 withIntermediateDirectories: true)
        
        save(files: files, toURL: directoryURL)
    }
    
    private func save(files: [ContentFile], toURL url: URL) {
        
        files.forEach { file in
            let path = url.appendingPathComponent(file.name)
            try! file.content.write(to: path,
                                    atomically: true,
                                    encoding: .utf8)
        }
    }
    
    private func createBasicThriftGeneratedFiles(fileURL: URL) {
        let directoryUrl = destinationURL.appendingPathComponent(FolderConstants.API)
        
        
        try! FileManager.default.createDirectory(at: directoryUrl,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
        
        shell("/usr/local/bin/thrift", "--gen", "swift", "-out", directoryUrl.path, fileURL.path)
    }
}

