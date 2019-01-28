//
//  SplashScreenViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/20/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateGraphic()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    @IBOutlet weak var secondMaskView: UIView!
    @IBOutlet weak var firstMaskView: UIView!
    @IBOutlet weak var secondMaskHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstMaskWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sproutLabel: UILabel!
    
    func animateGraphic() {
        firstMaskWidthConstraint.constant = 0
        UIView.animate(withDuration: 1.4, delay: 1, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
            self.firstMaskView.alpha = 0
            print("1")
        }) { (_) in
            self.secondMaskHeightConstraint.constant = 0
            UIView.animate(withDuration: 0.8, delay: 0, options: .layoutSubviews, animations: {
                self.view.layoutIfNeeded()
                self.secondMaskView.alpha = 0
                print("2")
            }, completion: { (_) in
                UIView.transition(with: self.sproutLabel, duration: 1.5, options: .transitionCrossDissolve, animations: {
                    self.sproutLabel.textColor = SproutTheme.current.textColor
                    self.view.backgroundColor = SproutTheme.current.backgroundColor
                }, completion: { (_) in
                    RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.0))
                    self.popToNavigationStack()
                })
            })
        }
    }
    
    
    func popToNavigationStack() {
        print("POP! hehe")
        self.performSegue(withIdentifier: "toNavigationStack", sender: nil)
    }
    
    var darkModeIsEnabled: Bool = SproutPreferencesController.shared.darkModeBool
    
}
