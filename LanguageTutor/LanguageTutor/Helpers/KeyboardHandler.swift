//
//  KeyboardHandler.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 17/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit


/// Generic class to observe for the keyboard notifications and methods to respond to it
protocol KeyboardHandler {
    
    var scrollView: UIScrollView! { get }
    var firstResponderForView: UIView! { get }
    
    func registerForKeyboardNotifications()
    func unregisterForKeyboardNotifications()
    func handleKeyboardAppearence(_ notification: Notification)
    func handleKeyboardDisappearance(_ notification: Notification)
}

extension KeyboardHandler where Self: UIViewController  {
    
    func registerForKeyboardNotifications() {
        
        //Add observer to get notification about keyboard.
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.handleKeyboardAppearence(_:)), name: UIResponder.keyboardDidShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.handleKeyboardDisappearance(_:)), name:  UIResponder.keyboardDidHideNotification , object: nil)
    }
    
    func unregisterForKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
}

extension UIViewController {
    
    @objc func handleKeyboardAppearence(_ notification: Notification) {
        if let KeyboardHandler = self as? KeyboardHandler {
            if let userInfo = (notification as NSNotification).userInfo {
                if let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    KeyboardHandler.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    KeyboardHandler.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
                    
                    let textField: UIView = KeyboardHandler.firstResponderForView
                    let bounds = textField.convert(textField.bounds, to: KeyboardHandler.scrollView)
                    KeyboardHandler.scrollView.scrollRectToVisible(bounds, animated: true)
                }
            }
        }
    }
    
    @objc func handleKeyboardDisappearance(_ notification: Notification) {
        if let KeyboardHandler = self as? KeyboardHandler {
            UIView.animate(withDuration: 0.2, animations: {
                KeyboardHandler.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                KeyboardHandler.scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            })
        }
    }
    
}

extension UIViewController {
    
    @objc func doneEditing() {
        self.view.endEditing(true)
    }
}


// MARK: - UIToolbar
extension UIToolbar {
    
    
    /// Returns the toolbar view with given properties
    /// Toolbar will have a action button which calls 'doneEditing' method on the target
    /// - Parameters:
    ///   - title: title of the action button in the toolbar
    ///   - target: object on which action has to be triggered
    /// - Returns: Fully initalised toolbar
    class func keyboardTopBar(withTitle title:String,target: UIViewController) -> UIToolbar {
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        keyboardDoneButtonView.backgroundColor = UIColor(named: Colors.tutorGray.rawValue)
        let doneButton = UIBarButtonItem(title: title, style: .done, target:target, action: #selector(UIViewController.doneEditing))
        doneButton.width   = keyboardDoneButtonView.frame.size.width
        doneButton.tintColor = UIColor.white
        keyboardDoneButtonView.items = [doneButton]
        return keyboardDoneButtonView
    }
}
