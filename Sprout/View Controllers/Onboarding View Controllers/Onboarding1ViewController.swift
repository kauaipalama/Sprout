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
        super.viewWillAppear(animated)
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
    
    func setupNextButton() {
        nextButton.backgroundColor = SproutTheme.current.tintedTextColor
        nextButton.tintColor = .white
        nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        nextButton.layer.cornerRadius = 8
        
        if SproutPreferencesController.shared.darkModeBool == true {
            nextButton.layer.shadowColor = UIColor.clear.cgColor
        } else {
            nextButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        }
    }
    
    func setupScene() {
        sceneLabel.textColor = SproutTheme.current.textColor
        sceneImageView.layer.shadowColor = UIColor.black.cgColor
        sceneImageView.layer.shadowOpacity = 0.5
        sceneImageView.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    func animateScene() {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.2))
        UIView.transition(with: self.sceneImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.layoutIfNeeded()
            self.sceneImageView.image = #imageLiteral(resourceName: "tableviewFull")
        }, completion: nil)
        //Add completion and set button enabled to true here to avoid "double stacking"
    }
    
    // MARK: - Actions
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        RootNavigationManager.shared.setLaunchStatus()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var sceneImageView: UIImageView!
    @IBOutlet weak var sceneLabel: UILabel!
}
