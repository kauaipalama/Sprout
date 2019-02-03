//
//  OnboardingSplashScreenViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/31/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class OnboardingSplashScreenViewController: UIViewController {
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        animateLogoImageView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Views
    
    func animateLogoImageView() {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
        
        UIView.transition(with: self.view, duration: 1.5, options: .transitionCrossDissolve, animations: {
            self.view.backgroundColor = SproutTheme.current.backgroundColor
        }) { (_) in
            UIView.animate(withDuration: 1, animations: {
                self.logoImageView.alpha = 0
            }) { (_) in
                self.popToOnboardingWelcome()
            }
        }
    }
    
    // MARK: - Navigation
    
    func popToOnboardingWelcome() {
        print("POP! hehe")
        self.performSegue(withIdentifier: "toOnboardingWelcome", sender: nil)
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var logoImageView: UIImageView!
}
