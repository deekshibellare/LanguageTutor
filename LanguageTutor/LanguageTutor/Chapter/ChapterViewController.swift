//
//  ViewController.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 17/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

class ChapterViewController: UIViewController {
    
    var viewModel:ChapterViewModel!
    weak var delegate: LessonViewControllerDelegate?
    
    // MARK: - Chapter Views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var chapterImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    // MARK: - Result Views
    @IBOutlet weak var resultHolderView: UIView!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var resultTitleLabel: UILabel!
    @IBOutlet weak var resultSubtitleLabel: UILabel!
    
    var keyboardToolBar:UIToolbar?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    // MARK: - Action methods
    @IBAction func doneAction(_ sender: UIButton) {
        if doneButton.isSelected {
            delegate?.continueToNextChaper()
        } else {
            processAnswer()
        }
    }
    
    override func doneEditing() {
        view.endEditing(true)
        doneAction(doneButton)
    }
    
    private func processAnswer() {
        guard let answer = answerTextField.text else {
            return
        }
        
        let result = viewModel.isCorrect(answer:answer)
        doneButton.isSelected.toggle()
        doneButton.backgroundColor = result.backgroundColor
        doneButton.setTitle("Check", for: .normal)
        
        showResultView(with: result)
        delegate?.userAnswered(question: self.viewModel.question, isCorrect: result.isCorrect)
    }
    
    // MARK: - UI
    private func updateUI() {
        
        keyboardToolBar = UIToolbar.keyboardTopBar(withTitle: "Continue", target: self)
        answerTextField.inputAccessoryView = keyboardToolBar
        answerTextField.delegate = self
        
        questionLabel.text = self.viewModel.question
        chapterImageView.image = UIImage(named: self.viewModel.question)
    }
    
    private func showResultView(with result:ChapterResultViewModel) {
        resultTitleLabel.text = result.title
        resultSubtitleLabel.text = result.subtitle
        resultView.backgroundColor = result.backgroundColor
        UIView.animate(withDuration: 0.3) {
            self.resultHolderView.isHidden.toggle()
        }
    }
    
    private func updateDoneButton(isEnabled:Bool) {
        self.doneButton.isEnabled = isEnabled
        let backgroundColor = isEnabled ? UIColor.blue : UIColor.lightGray
        self.doneButton.backgroundColor = backgroundColor
        keyboardToolBar?.barTintColor = backgroundColor
    }
}

// MARK: - KeyboardHandler
extension ChapterViewController:KeyboardHandler {
    
    var firstResponderForView: UIView! {
        return answerTextField
    }
}

// MARK: UITextFieldDelegate
extension ChapterViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let oldString = textField.text {
            let newString = oldString.replacingCharacters(in: Range(range, in: oldString)!,
                                                          with: string)
            updateDoneButton(isEnabled: newString.isEmpty == false)
        }
        return true
    }
}
