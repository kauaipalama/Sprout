//
//  SetPreferencesMessageViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 2/12/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit
import Photos

class SetPreferencesMessageViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
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
        view.backgroundColor = SproutTheme.current.backgroundColor
        messageLabel.textColor = SproutTheme.current.textColor
        
        setupNextButton()
        setNavigationControllerColors()
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
}

