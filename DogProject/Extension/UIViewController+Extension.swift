//
//  UIViewController+Extension.swift
//  DogProject
//
//  Created by Talha Batuhan Irmalı on 26.11.2022.
//

import UIKit

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return
            storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}
