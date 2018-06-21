//
//  CSVParser.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 17/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit
typealias CompletionHandler = (_ objects:[[String:String]]?) -> Void

class CSV {
    
    var fileName:String
    var delimiter:String = ","
    var endOfLine = "\r\n"
    var newLine = "\n"
    
    init(fileName:String,delimiter:String = ",") {
        self.fileName = fileName
        self.delimiter = delimiter
    }
    
    func read(_ completionHandler:@escaping CompletionHandler) {
        DispatchQueue.global().async {
            
            guard let contents = PersistenceStore.load(lesson: self.fileName) else {
                return DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            
            // Get rows
            //All rows are separated either by "\r\n" or by "\n"
            //First we split the contents by "r\n"
            var rows  = contents.components(separatedBy:self.endOfLine).filter{ $0.isEmpty == false }
            //Further each row is split into array of rows separated by "\n" and reduced back into rows
            rows = rows.map({ (string) -> [String] in
                return string.components(separatedBy:self.newLine)
            }).reduce([], +).filter{ $0.isEmpty == false }
            
            guard let header = rows.first else {
                return DispatchQueue.main.async {
                    completionHandler(nil)
                }
            }
            
            //Extract header keys. These keys will act as keys of the object
            let headerKeys = header.components(separatedBy: self.delimiter)
            
            //drop the header
            let dataRows = rows.dropFirst()
            
            var objects = [[String:String]]()
            for row in dataRows {
                let rowValues = row.components(separatedBy: self.delimiter)
                //construct object using header keys and row values
                let dictionary = Dictionary(keys: headerKeys, values: rowValues)
                objects.append(dictionary)
            }
            
            DispatchQueue.main.async {
                completionHandler(objects)
            }
        }
    }
    
    func write(headerKeys:[String],objects:[[String:String]]) {
        var stringData = headerKeys.joined(separator: self.delimiter) + endOfLine
        for object in objects {
            var rowValues = [String]()
            for key in headerKeys {
                rowValues.append(object[key] ?? "")
            }
            let rowData = rowValues.joined(separator: self.delimiter) + endOfLine
            stringData += rowData
        }
        PersistenceStore.save(lesson: stringData, withName: self.fileName)
    }
}

extension Dictionary {
    init(keys: [Key], values: [Value]) {
        self.init()
        
        for (key, value) in zip(keys, values) {
            self[key] = value
        }
    }
}
