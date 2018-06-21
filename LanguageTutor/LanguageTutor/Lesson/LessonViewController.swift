//
//  LessonViewController.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 19/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit

protocol LessonViewControllerDelegate: class {
    func continueToNextChaper()
    func userAnswered(question:String,isCorrect:Bool)
}

class LessonViewController: UIPageViewController {
    
    var viewModel:LessonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let initialViewController = self.viewController(at: 0) {
            scroll(to:initialViewController)
        }
    }
    
    private func viewController(at index:Int) -> UIViewController? {
        guard let lastIndex = viewModel.lastIndex,index <= lastIndex, index >= 0  else {
            return nil
        }
        return self.newChapaterViewController(at: index)
    }
    
    private func newChapaterViewController(at index:Int) -> UIViewController {
        let storyBoard = UIStoryboard(.main)
        let chapterViewController:ChapterViewController = storyBoard.instantiateViewController()
        let chapterViewModel = viewModel.chapter(at: index)
        chapterViewController.viewModel = chapterViewModel
        chapterViewController.delegate = self
        return chapterViewController
    }
    
    
    private func scrollToNextViewController() {
        let nextIndex = viewModel.currentIndex + 1
        if let nextViewController = viewController(at:nextIndex){
            scroll(to:nextViewController)
        } else {
            showResultViewController()
        }
    }
    
    private func showResultViewController() {
        let storyBoard = UIStoryboard(.main)
        let resultViewController:ResultViewController = storyBoard.instantiateViewController()
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
    
    private func scrollToViewController(index newIndex: Int) {
        if let viewController = viewController(at: newIndex) {
            let currentIndex = viewModel.currentIndex
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            scroll(to:viewController, direction: direction)
        }
    }
    
    private func scroll(to viewController: UIViewController,
                        direction: UIPageViewController.NavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            self.viewModel.currentIndex += 1
        })
    }
}

extension LessonViewController:LessonViewControllerDelegate {
    func userAnswered(question: String, isCorrect: Bool) {
        self.viewModel.updateChapter(withQuestion: question, isCorrectAnswer: isCorrect)
    }
    
    func continueToNextChaper() {
        self.scrollToNextViewController()
    }
}
