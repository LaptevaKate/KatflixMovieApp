//
//  UIViewController+Extension.swift
//  KatflixMovieApp
//
//  Created by Екатерина Лаптева on 21.02.24.
//

import UIKit
extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        return storyboard.instantiateViewController(identifier: identifier) as! Self
    }
}
