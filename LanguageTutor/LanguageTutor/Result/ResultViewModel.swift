//
//  ResultViewModel.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 21/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

struct ResultViewModel {
    
    var title:String
    var isLessonCompleted:Bool
    var correctAnswer:Int
    var wrongAnswer:Int
    
    var successMessage:String {
        if isLessonCompleted {
            return "Congratulation, You have just finished the lesson successfully!"
        }
        return "You have successfully finished the lesson!"
    }
    
    var correctAnswerText:String {
        if isLessonCompleted {
            return ""
        }
        return "Correct: \(correctAnswer)"
    }
    
    var wrongAnswerText:String {
        if isLessonCompleted {
            return ""
        }
        return "Wrong: \(wrongAnswer)"
    }
    
    var shouldHideRestartButton:Bool {
        return self.isLessonCompleted
    }
}
