//
//  IntroViewModel.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 21/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation

class IntroViewModel {
    
    var lesson:Lesson?
    
    func fetchLesson(completion:@escaping (Lesson?)->()) {
        
        let csv = CSV(fileName:"Introduction")
        csv.read { [weak self]objects in
            guard let chapters = objects else {
                completion(nil)
                return
            }
            self?.lesson = Lesson(name:"Introduction", chapters:chapters)
            completion(self?.lesson)
        }
    }
    
    func createDatabase() {
        _ = PersistenceStore.createLocalUrlforDataAsset(withName:"Introduction")
    }
}
