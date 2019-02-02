//
//  WelcomeScreenViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/30/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.borderView.layer.borderWidth = 4
        self.borderView.layer.cornerRadius = 8
        self.borderView.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.borderView.layer.shadowOpacity = 0.75
        
        self.nextButton.layer.cornerRadius = 8
        self.nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.nextButton.layer.shadowOpacity = 0.75
        self.nextButton.layer.borderWidth = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = SproutTheme.current.backgroundColor
        self.nextButton.isEnabled = false
        self.nextButton.alpha = 0
        self.nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        self.nextButton.tintColor = .white
        self.nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        self.nextButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
        self.borderView.alpha = 0
        self.welcomeLabel.text = ""
        self.borderViewCenterY.constant = 0
        self.borderView.layer.borderColor = SproutTheme.current.accentColor.cgColor
        self.borderView.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        if SproutPreferencesController.shared.darkModeBool == true {
            self.borderView.backgroundColor = SproutTheme.current.textFieldBackgroundColor
            self.welcomeLabel.textColor = SproutTheme.current.textColor

        } else {
            self.borderView.backgroundColor = SproutTheme.current.backgroundColor
            self.welcomeLabel.textColor = SproutTheme.current.textColor
        }
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.75) {
            self.view.layoutIfNeeded()
            self.view.backgroundColor = SproutTheme.current.backgroundColor
        }
        
        UIView.transition(with: self.welcomeLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
            self.welcomeLabel.text = "Welcome to Sprout"
        }) { (_) in
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.75))
            UIView.transition(with: self.welcomeLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                self.welcomeLabel.text = ""
            }, completion: { (_) in
                UIView.transition(with: self.welcomeLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                    self.welcomeLabel.text = "Before you\nget started\nlets set some\npreferences"
                }, completion: { (_) in
                    RunLoop.current.run(until: Date(timeIntervalSinceNow: 2))
                    self.borderViewCenterY.constant = -(self.view.frame.maxX) / 10
                    UIView.animate(withDuration: 0.75, animations: {
                        self.view.layoutIfNeeded()
                        print("Animating constraint up")
                    }, completion: { (_) in
                        UIView.animate(withDuration: 0.25, animations: {
                            //When do I actually call this? Why?
                            self.view.layoutIfNeeded()
                            self.nextButton.alpha = 1
                        }, completion: { (_) in
                            self.nextButton.isEnabled = true
                        })
                    })
                })
            })
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var borderViewCenterY: NSLayoutConstraint!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
