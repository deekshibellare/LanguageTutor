//
//  ChapterViewModel.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 20/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit

struct ChapterViewModel {
    
    let question:String
    let answer:String
    let title:String
    
    func isCorrect(answer text:String) -> ChapterResultViewModel {
        
        if text.lowercased() == answer.lowercased() {
            //Correct answer
            let resultViewModel =
                ChapterResultViewModel(isCorrect: true,
                                       backgroundColor: UIColor(named: Colors.tutorGreen.rawValue),
                                       title: "Correct",
                                       subtitle: "Yes, \(question) is \(answer.capitalized)")
            return resultViewModel
        }
        
        //Wrong answer
        let resultViewModel =
            ChapterResultViewModel(isCorrect: false,
                                   backgroundColor: UIColor(named: Colors.tutorRed.rawValue),
                                   title: "Wrong",
                                   subtitle: "No, \(question) is \(answer.capitalized)")
        return resultViewModel
    }
}

struct ChapterResultViewModel {
    let isCorrect:Bool
    let backgroundColor:UIColor?
    let title:String
    let subtitle:String
}
