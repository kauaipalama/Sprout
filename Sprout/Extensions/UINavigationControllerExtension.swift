//
//  UINavigationControllerExtension.swift
//  Sprout
//
//  Created by Kainoa Palama on 11/20/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.topViewController
    }

}
