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
    var isCompleted:Bool = false
    var chapters = [Chapter]()
    var chapterFinishCount:Int = 4
    
    var correctAnswers:Int = 0
    var wrongAnswers:Int = 0
    
    var totalChapters:Int {
        return chapters.count
    }
    
    // MARK: Init
    init(name:String,chapters chaptersArray:[[String:String]]) {
        self.name = name
        for chapterDict in chaptersArray {
            if let chapter = Chapter(dictionary: chapterDict) {
                self.chapters.append(chapter)
            }
        }
    }
    
    func encode() -> [[String:String]] {
        
        var encodedChapters = [[String:String]]()
        for chapter in self.chapters {
            encodedChapters.append(chapter.encode())
        }
        return encodedChapters
    }
    
    // MARK: Public methods
    func completedChapters() -> [Chapter]? {
        let completedChapters = chapters.filter{ $0.completionCount >= chapterFinishCount }
        return completedChapters
    }
    
    func remainingChapters() -> [Chapter]? {
        let remainingChapters = chapters.filter{ $0.completionCount < chapterFinishCount }
        return remainingChapters
    }
    
    func updateChapter(withQuestion question:String,isCorrectAnswer:Bool) -> Bool {
        guard let chapter = chapters.filter({$0.question == question}).first else {
            return false
        }
        chapter.completionCount += isCorrectAnswer ? 1 : -1
        
        //update counters
        if isCorrectAnswer {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
        return true
    }
}

