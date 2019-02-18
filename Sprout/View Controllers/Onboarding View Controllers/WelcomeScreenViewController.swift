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
        print(self.view.frame.origin.y)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateViews()
        print(self.view.frame.origin.y)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Views
    
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
        welcomeLabel.text = ""
        //Will need new constraint to animate up
        view.backgroundColor = SproutTheme.current.backgroundColor
        welcomeLabel.textColor = SproutTheme.current.textColor
        skipButton.alpha = 0
        skipButton.isEnabled = false
        
        setupNextButton()
        setNavigationControllerColors()
    }
    
    func animateViews() {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        UIView.transition(with: self.welcomeLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
            self.welcomeLabel.text = "Welcome to Sprout"
        }) { (_) in
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.75))
            UIView.transition(with: self.welcomeLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                self.welcomeLabel.text = ""
            }, completion: { (_) in
                UIView.transition(with: self.welcomeLabel, duration: 0.75, options: .transitionCrossDissolve, animations: {
                    self.welcomeLabel.text = "Simple, lightweight\ncrop management."
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.25, animations: {
                        self.view.layoutIfNeeded()
                        self.nextButton.alpha = 1
                        self.skipButton.alpha = 1
                    }, completion: { (_) in
                        self.nextButton.isEnabled = true
                        self.skipButton.isEnabled = true
                    })
                })
            })
        }
    }
    
    // MARK: - Outlets
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        
    }
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
}
