//
//  RootNavigationManager.swift
//  Sprout
//
//  Created by Kainoa Palama on 3/23/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class RootNavigationManager {
    
    static let shared = RootNavigationManager()
    
    let userHasLaunched = UserDefaults.standard.bool(forKey: "userHasLaunched")
    
    var initialViewControllerID: String = ""
    
    func setLaunchStatus() {
        UserDefaults.standard.set(true, forKey: "userHasLaunched")
    }
    
    func setInitialViewController(window: UIWindow?) {
        let storyboard = UIStoryboard(name: "SplashScreen", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier:initialViewControllerID )
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    
    init() {
        if userHasLaunched == false {
            initialViewControllerID = "onboardingSplashScreen"
            print("First time")
        } else {
            initialViewControllerID = "splashScreen"
            print("Not first time")
        }
    }
    
    
}
