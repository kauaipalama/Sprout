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
        //System ask for permission
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (_) in
            //Do Something
            PHPhotoLibrary.requestAuthorization { (_) in
                //Do Somthing
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "toFarewellVC", sender: nil)
                }
            }
        }
    }
    
    // MARK: - Outlets
    
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var permissionsButtons: [UIButton]!
    
}
