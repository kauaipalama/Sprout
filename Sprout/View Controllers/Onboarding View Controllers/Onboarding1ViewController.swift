//
//  Onboarding1ViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/31/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class Onboarding1ViewController: UIViewController {
    
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
    
    func setupViews() {
        self.view.backgroundColor = SproutTheme.current.backgroundColor
        setNavigationControllerColors()
        setupBorderView()
        setupNextButton()
    }
    
    func setNavigationControllerColors() {
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
    }
    
    func setupBorderView() {
        borderView.layer.borderWidth = 4
        borderView.layer.cornerRadius = 8
        borderView.layer.shadowOffset = CGSize(width: 2, height: 2)
        borderView.layer.shadowOpacity = 0.75
        
        borderViewCenterY.constant = 0
        
        borderView.layer.borderColor = SproutTheme.current.accentColor.cgColor
        borderView.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        
        if SproutPreferencesController.shared.darkModeBool == true {
            borderView.backgroundColor = SproutTheme.current.textFieldBackgroundColor
        } else {
            borderView.backgroundColor = SproutTheme.current.backgroundColor
        }
    }
    
    func setupNextButton() {
        nextButton.isEnabled = false
        nextButton.alpha = 0
        nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        nextButton.tintColor = .white
        nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        nextButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
        nextButton.layer.cornerRadius = 8
        nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        nextButton.layer.shadowOpacity = 0.75
        nextButton.layer.borderWidth = 2
    }
    
    func animateViews() {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1))
        self.borderViewCenterY.constant = -(self.view.frame.maxX) / 10
        UIView.animate(withDuration: 0.75, animations: {
            self.view.layoutIfNeeded()
            self.nextButton.alpha = 1
        }) { (_) in
            self.nextButton.isEnabled = true
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var borderViewCenterY: NSLayoutConstraint!
}
