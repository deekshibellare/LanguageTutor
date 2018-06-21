//
//  IntroViewController.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 20/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit

//Welcome screen. Introduces the user to the app and moves to lesson controller
class IntroViewController: UIViewController {
    
    let viewModel = IntroViewModel()
    
    @IBOutlet var introViews: [UIView]!
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.createDatabase()
        viewModel.fetchLesson { (lesson) in
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIntroViews()
    }
    
    // MARK: Action methods
    @IBAction func showLessoon(_ sender: Any) {
        
        if let lesson = viewModel.lesson {
            showLessonController(with: lesson)
        } else {
            viewModel.fetchLesson { [weak self](lesson) in
                guard let lesson = lesson else {
                    return
                }
                self?.showLessonController(with: lesson)
            }
        }
    }
    
    // MARK: Private methods
    private func showLessonController(with lesson:Lesson) {
        
        let storyBoard = UIStoryboard(.main)
        let lessonViewController:LessonViewController = storyBoard.instantiateViewController()
        let lessonViewModel = LessonViewModel(lesson: lesson)
        lessonViewController.viewModel = lessonViewModel
        self.navigationController?.pushViewController(lessonViewController, animated: true)
    }
    
    func animateIntroViews() {
        UIView.animate(withDuration:0.3){
            for view in self.introViews {
                view.isHidden = false
            }
        }
    }
}

