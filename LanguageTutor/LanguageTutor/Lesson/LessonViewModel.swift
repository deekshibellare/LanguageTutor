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
        guard let totalChapters  = self.lesson?.chapters.count else {
            return nil
        }
        return totalChapters - 1
    }
    
    func updateChapter(withQuestion question:String,isCorrectAnswer:Bool){
        _ = self.lesson?.updateChapter(withQuestion: question,
                                       isCorrectAnswer: isCorrectAnswer)
    }
    
    func chapter(at index:Int) -> ChapterViewModel? {
        guard let lastIndex = self.lastIndex,
            index <= lastIndex, index >= 0  else {
            return nil
        }
        let chapter = self.lesson?.chapters[index]
        let question = chapter?.question ?? ""
        let answer = chapter?.answer ?? ""
        let title = self.lesson?.name ?? ""
        let chapterViewModel = ChapterViewModel(question: question,
                                                answer: answer,
                                                title: title)
        return chapterViewModel
    }
    
    init(lesson:Lesson) {
        self.lesson = lesson
    }
}
