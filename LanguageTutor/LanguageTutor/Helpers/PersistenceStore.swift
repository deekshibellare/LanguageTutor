//
//  ParsistanceStore.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 18/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit

final class PersistenceStore {
    
    static func urlforFile(lessonName:String) -> URL? {
        
        if lessonName.isEmpty == true{
            return nil
        }
        var url = self.doumentDirectoryURL()
        url.appendPathComponent(lessonName)
        url.appendPathExtension("csv")
        return url
    }
    
    static private func doumentDirectoryURL() -> URL {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1] as URL
    }
    
    static func save(lesson:String,withName name:String) {
        let data = Data(lesson.utf8)
        guard let url = urlforFile(lessonName:name) else {
            return
        }
        try? data.write(to: url)
    }
    
    static func load(lesson name:String) -> String? {
        
        guard let url = urlforFile(lessonName:name) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return String(data:data, encoding: .utf8)
    }
    
    static func createLocalUrlforDataAsset(withName name: String) -> URL? {
        
        guard let url = PersistenceStore.urlforFile(lessonName:name) else {
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
}

