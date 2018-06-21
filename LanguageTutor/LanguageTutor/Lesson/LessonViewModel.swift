//
//  LessonViewModel.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 20/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

struct LessonViewModel {
    
    var lesson:Lesson?
    var currentIndex:Int = -1
    var lastIndex:Int? {
        guard let totalChapters  = self.lesson?.remainingChapters.count else {
            return nil
        }
        return totalChapters - 1
    }
    
    var correctAnswers:Int = 0
    var wrongAnswers:Int = 0
    
    // MARK: Init
    init(lesson:Lesson) {
        self.lesson = lesson
    }
    
    // MARK: Public methods
    mutating func updateChapter(withQuestion question:String,isCorrectAnswer:Bool){
        _ = self.lesson?.updateChapter(withQuestion: question,
                                       isCorrectAnswer: isCorrectAnswer)
        
        if isCorrectAnswer {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
    }
    
    func chapter(at index:Int) -> ChapterViewModel? {
        guard let lastIndex = self.lastIndex,
            index <= lastIndex, index >= 0  else {
                return nil
        }
        let chapter = self.lesson?.remainingChapters[index]
        let question = chapter?.question ?? ""
        let answer = chapter?.answer ?? ""
        let title = self.lesson?.name ?? ""
        let chapterViewModel = ChapterViewModel(question: question,
                                                answer: answer,
                                                title: title)
        return chapterViewModel
    }
    
    mutating func restart() {
        
        currentIndex = -1
        correctAnswers = 0
        wrongAnswers = 0
        self.lesson?.computeRemainingChapters()
    }
    
    func save() {
        
        guard let lessonDict = lesson?.encode() else {
            return
        }
        
        guard let lessonName = lesson?.name else {
            return
        }
        
        let csv = CSV(fileName:lessonName)
        
        let keys =  ["German","English","Count"]
        csv.write(headerKeys: keys, objects:lessonDict)
    }
    
    func result() -> ResultViewModel {
        
        let title = lesson?.name ?? ""
        let isLessonCompleted = lesson?.isLessonCompleted() ?? false
        let result = ResultViewModel(title: title, isLessonCompleted: isLessonCompleted, correctAnswer: correctAnswers, wrongAnswer: wrongAnswers)
        return result
    }
}
