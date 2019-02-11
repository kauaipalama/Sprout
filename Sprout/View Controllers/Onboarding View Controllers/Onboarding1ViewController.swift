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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateScene()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Views
    
    func setupViews() {
        self.view.backgroundColor = SproutTheme.current.backgroundColor
        setNavigationControllerColors()
        setupNextButton()
        setupScene()
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
        nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        nextButton.tintColor = .white
        nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        nextButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
        nextButton.layer.cornerRadius = 8
        nextButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        nextButton.layer.shadowOpacity = 0.75
        nextButton.layer.borderWidth = 2
    }
    
    func setupScene() {
        sceneLabel.textColor = SproutTheme.current.textColor
        sceneImageView.loadGif(asset: "Onboarding Scene 1")
        scenePlaceholderImage.image = UIImage(named: "Onboarding Scene 1 Placeholder")
    }
    
    func animateScene() {
        sceneImageView.startAnimating()
        scenePlaceholderImage.alpha = 0
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var scenePlaceholderImage: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var borderViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var sceneImageView: UIImageView!
    @IBOutlet weak var sceneLabel: UILabel!
}
