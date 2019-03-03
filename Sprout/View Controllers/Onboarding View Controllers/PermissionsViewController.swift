//
//  Onboarding1ViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/31/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit
import Photos

class PermissionsViewController: UIViewController {
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Views
    
    func setupViews() {
        self.view.backgroundColor = SproutTheme.current.backgroundColor
        setNavigationControllerColors()
        setupNextButton()
        setupMessage()
    }
    
    func setNavigationControllerColors() {
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
    }
    
    func setupNextButton() {
        for button in permissionsButtons {
            button.backgroundColor = SproutTheme.current.tintedTextColor
            button.tintColor = .white
            button.layer.shadowColor = SproutTheme.current.accentColor.cgColor
            button.layer.cornerRadius = 8
            if SproutPreferencesController.shared.darkModeBool == true {
                button.layer.shadowColor = UIColor.clear.cgColor
            } else {
                button.layer.shadowColor = SproutTheme.current.accentColor.cgColor
            }
        }
        
    }
    
    func setupMessage() {
        messageLabel.textColor = SproutTheme.current.textColor
    }
    @IBAction func permissionsButtonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Camera / Photo Library", message: "\nSprout will use your Camera to capture an image as part of a Plant Record.\n\nYou may also choose to use an image from your Photo Library as part of a Plant Record.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Do Not Allow", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "toFarewellVC", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Allow", style: .default, handler: { (_) in
            self.performSegue(withIdentifier: "toFarewellVC", sender: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var permissionsButtons: [UIButton]!
    
}
