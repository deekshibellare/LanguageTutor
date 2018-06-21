//
//  ResultViewController.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 20/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import Foundation
import UIKit

//Displays the results of current run of lesson and navigates for re run if user wants it
class ResultViewController: UIViewController {
    
    var viewModel:ResultViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var wrongAnswerLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        self.titleLabel.text = viewModel.title
        self.successLabel.text = viewModel.successMessage
        self.correctAnswerLabel.text = viewModel.correctAnswerText
        self.wrongAnswerLabel.text = viewModel.wrongAnswerText
        self.restartButton.isHidden = viewModel.shouldHideRestartButton
    }
    
    @IBAction func restartTapped(_ sender: Any) {
        
        guard let lessonViewController:LessonViewController = self.navigationController?.firstController() else {
            return
        }
        lessonViewController.restart()
        self.navigationController?.popToViewController(lessonViewController, animated: true)
    }
}

