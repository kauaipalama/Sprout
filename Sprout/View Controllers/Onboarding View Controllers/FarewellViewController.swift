//
//  FarewellViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 1/30/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import UIKit

class FarewellViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupViews() {
        setNavigationControllerColors()
        view.backgroundColor = SproutTheme.current.backgroundColor
        messageLabel.textColor = SproutTheme.current.textColor
        logoImageView.alpha = 0
        setupDoneButton()
    }
    
    func setNavigationControllerColors() {
        navigationController?.navigationBar.barTintColor = SproutTheme.current.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: SproutTheme.current.textColor]
    }
    
    func setupDoneButton() {
        doneButton.backgroundColor = SproutTheme.current.tintedTextColor
        doneButton.tintColor = .white
        doneButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        doneButton.layer.borderColor = UIColor(red: 87.0/255.0, green: 123.0/255.0, blue: 180.0/255.0, alpha: 1.0).cgColor
        doneButton.layer.cornerRadius = 8
        doneButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        doneButton.layer.shadowOpacity = 0.75
        doneButton.layer.borderWidth = 2
        if SproutPreferencesController.shared.darkModeBool == true {
            doneButton.layer.shadowColor = UIColor.clear.cgColor
        } else {
            doneButton.layer.shadowColor = SproutTheme.current.accentColor.cgColor
        }
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.75, animations: {
            self.messageLabel.alpha = 0
            self.doneButton.alpha = 0
            self.navigationController?.navigationBar.alpha = 0
        }) { (_) in
            RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.75))
            UIView.transition(with: self.logoImageView, duration: 0.75, options: .curveEaseIn, animations: {
                self.logoImageView.alpha = 1
            }) { (_) in
                RunLoop.current.run(until: Date(timeIntervalSinceNow: 1.5))
                self.performSegue(withIdentifier: "toTouchdownVC", sender: nil)
            }
        }
    }
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
}
