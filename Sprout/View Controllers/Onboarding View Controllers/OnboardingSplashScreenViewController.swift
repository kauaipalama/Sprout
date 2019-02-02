//
//  OnboardingSplashScreenViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/31/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class OnboardingSplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
        animateLogoImageView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    func animateLogoImageView() {
        
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
    
    func popToOnboardingWelcome() {
        print("POP! hehe")
        self.performSegue(withIdentifier: "toOnboardingWelcome", sender: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
