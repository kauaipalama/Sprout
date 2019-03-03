//
//  OnboardingTouchdownViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 2/17/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class OnboardingTouchdownViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateGraphic()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var secondMaskView: UIView!
    @IBOutlet weak var firstMaskView: UIView!
    @IBOutlet weak var secondMaskHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstMaskWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var sproutLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoImageViewCenterYConstraint: NSLayoutConstraint!
    
    func setupViews() {
        firstMaskView.backgroundColor = SproutTheme.current.backgroundColor
        secondMaskView.backgroundColor = SproutTheme.current.backgroundColor
        sproutLabel.textColor = SproutTheme.current.textColor
        view.backgroundColor = SproutTheme.current.backgroundColor
    }
    
    func animateGraphic() {
        let newCenterYConstraint = NSLayoutConstraint(item: logoImageView, attribute: .centerY, relatedBy: .equal, toItem: self.view.superview, attribute: .centerY, multiplier: 0.92, constant: 0)
        
        UIView.animate(withDuration: 0.75, delay: 0.5, options: .curveEaseInOut, animations: {
            self.logoImageViewCenterYConstraint.isActive = false
            newCenterYConstraint.isActive = true
            self.view.layoutIfNeeded()
        }) { (_) in
            self.firstMaskWidthConstraint.constant = 0
            UIView.animate(withDuration: 1.4, delay: 0, options: .curveLinear, animations: {
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
                        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
                        UIView.transition(with: self.sproutLabel, duration: 1, options: .transitionCrossDissolve, animations: {
                            self.sproutLabel.textColor = .clear
                            self.logoImageView.alpha = 0
                        }, completion: { (_) in
                            self.popToNavigationStack()
                        })
                    })
                })
            }
        }
    }
    
    
    func popToNavigationStack() {
        print("POP! hehe")
        self.performSegue(withIdentifier: "toNavigationStack", sender: nil)
    }
    
    var darkModeIsEnabled: Bool = SproutPreferencesController.shared.darkModeBool
    
}
