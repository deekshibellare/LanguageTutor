//
//  Chapter.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 21/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

class Chapter {
    var question:String
    var answer:String
    var completionCount:Int
    
    init?(dictionary:[String:String]) {
        
        guard let question = dictionary["German"],
            let answer = dictionary["English"],
            let completionCountString = dictionary["Count"],
            let count = Int(completionCountString) else {
                return nil
        }
        self.question = question
        self.answer = answer
        self.completionCount = count
    }
    
    func encode() -> [String:String] {
        var dictionary = [String:String]()
        dictionary["German"] = question
        dictionary["English"] = answer
        dictionary["Count"] = "\(completionCount)"
        return dictionary
    }
}
