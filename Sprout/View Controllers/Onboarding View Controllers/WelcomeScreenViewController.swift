//
//  WelcomeScreenViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/30/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class WelcomeScreenViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Views
    
    func setNavigationControllerColors() {
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
    }
    
    func setupNextButton() {
        nextButton.layer.cornerRadius = 8
        nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        nextButton.layer.shadowOpacity = 0.75
        nextButton.layer.borderWidth = 2
        nextButton.isEnabled = false
        nextButton.alpha = 0
        nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        nextButton.tintColor = .white
        if SproutPreferencesController.shared.darkModeBool == true {
            nextButton.layer.shadowColor = UIColor.clear.cgColor
        } else {
            nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        }
        nextButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
    }
    
    func setupViews() {
        //Will remove borderView from storyboard later
        borderView.alpha = 0
        welcomeLabel.text = ""
        //Will need new constraint to animate up
        borderViewCenterY.constant = 0
        
        view.backgroundColor = SproutTheme.current.backgroundColor
        welcomeLabel.textColor = SproutTheme.current.textColor
        
        
        setupNextButton()
        setNavigationControllerColors()
    }
    
    func animateViews() {
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
    
    // MARK: - Outlets
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var borderViewCenterY: NSLayoutConstraint!
}
