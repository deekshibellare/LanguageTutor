//
//  NavigationHelper.swift
//  LanguageTutor
//
//  Created by Deekshith Bellare on 21/06/18.
//  Copyright © 2018 Deekshith Bellare. All rights reserved.
//

import UIKit

extension UINavigationController {
    //Returns the first controller from the navigation controller stack that matches the type T
    func firstController<T: UIViewController>()  -> T?{
        if let vc = viewControllers.first(where: { $0 is T }) {
            return vc as? T
        }
        return nil
    }
}
