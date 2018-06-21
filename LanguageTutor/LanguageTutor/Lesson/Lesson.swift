//
//  Lesson.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 18/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

class Lesson {
    
    var name:String?
    var allChapters = [Chapter]()
    var remainingChapters = [Chapter]()
    var chapterFinishCount:Int = 4
    
    var totalChapters:Int {
        return allChapters.count
    }
    
    // MARK: Init
    init(name:String,chapters chaptersArray:[[String:String]]) {
        self.name = name
        for chapterDict in chaptersArray {
            if let chapter = Chapter(dictionary: chapterDict) {
                self.allChapters.append(chapter)
            }
        }
        self.computeRemainingChapters()
    }
    
    func computeRemainingChapters()  {
        let remainingChapters = allChapters.filter{ $0.completionCount < chapterFinishCount }
        self.remainingChapters = remainingChapters
    }
    
    func encode() -> [[String:String]] {
        
        var encodedChapters = [[String:String]]()
        for chapter in self.allChapters {
            encodedChapters.append(chapter.encode())
        }
        return encodedChapters
    }
    
    // MARK: Public methods
    func completedChapters() -> [Chapter]? {
        let completedChapters = allChapters.filter{ $0.completionCount >= chapterFinishCount }
        return completedChapters
    }
    
    func isLessonCompleted() -> Bool {
        return allChapters.allSatisfy{$0.completionCount >= chapterFinishCount}
    }
    
    func updateChapter(withQuestion question:String,isCorrectAnswer:Bool) -> Bool {
        guard let chapter = allChapters.filter({$0.question == question}).first else {
            return false
        }
        chapter.completionCount += isCorrectAnswer ? 1 : -1
        return true
    }
}

