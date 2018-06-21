//
//  UIStoryboard+Helper.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 17/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit
// MARK: - Identifies each storyboard though identifier.
protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

// MARK: - Indentifies each storyboard from its classname.
extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

/* MARK: - Extension to intialise the viewcontroller in a consise way. Intialised viewController is automatically typecasted to the type specified during initaliation
 Old way
 
 ```
 let storyBoard = UIStoryboard(name: "Main", bundle: nil)
 let viewController = storyBoard.instantiateViewControllerWithIdentifier("viewControllerID") as! BrowseViewController
 ```
 
 New way
 ```
 let storyBoard = UIStoryboard(storyboard: .Library)
 let viewController: TipViewController = storyBoard.instantiateViewController()
 ```
 */
extension UIStoryboard {
    
    /// The uniform place where we state all the storyboard we have in our application
    enum Storyboard: String {
        case main = "Main"
    }
    
    
    /// creates a storyboard instance
    ///
    /// - parameter storyboard: Storyboard enum type which has respective storyboard name to be initalised
    /// - parameter bundle:     bundle name which has the storyboard
    ///
    convenience init(_ storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    /// Class Functions
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    
    func instantiateViewController<T: UIViewController>() -> T  {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        return viewController
    }
}

extension UIViewController: StoryboardIdentifiable {
}
