//
//  ParsistanceStore.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 18/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit


/// Saves/Retreives the data from the document directory
final class PersistenceStore {
    
    /// Save the data as a file to the document directory
    ///
    /// - Parameters:
    ///   - lesson: String represenation of contents of file to be saved
    ///   - name: Name of the file
    static func save(data:String,withName name:String) {
        let data = Data(data.utf8)
        guard let url = urlforFile(name:name) else {
            return
        }
        try? data.write(to: url)
    }
    
    
    /// Load the file from the document directory
    ///
    /// - Parameter name: Name/filename of the document to be loaded
    /// - Returns: String representation of the data of the file if present or else nil
    static func load(lesson name:String) -> String? {
        
        guard let url = urlforFile(name:name) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return String(data:data, encoding: .utf8)
    }
    
    
    /// Move the file from the asset catalog to document directory
    /// We can't wrtie to the file in asset catalog. Hence the files are need to be moved to document directory
    /// - Parameter name: Name of the data file in the asset catalog
    /// - Returns: Url of the file in the document directory
    static func createLocalUrlforDataAsset(withName name: String) -> URL? {
        
        guard let url = PersistenceStore.urlforFile(name:name) else {
            return nil
        }
        
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: url.path) else {
            
            guard let data = NSDataAsset(name: name)?.data
                else { return nil }
            
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
        return url
    }
    
    //Url of the file in the document directory with given name and file extension
    static private func urlforFile(name:String,fileExtension:String="csv") -> URL? {
        
        if name.isEmpty == true{
            return nil
        }
        var url = self.doumentDirectoryURL()
        url.appendPathComponent(name)
        url.appendPathExtension(fileExtension)
        return url
    }
    
    //Document directory URL
    static private func doumentDirectoryURL() -> URL {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1] as URL
    }
    
}

