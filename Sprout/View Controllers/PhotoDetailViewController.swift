//
//  PhotoDetailViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//Looks good

import UIKit

class PhotoDetailViewController: UIViewController, UIScrollViewDelegate{
    
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        print(self.view.frame.origin.y)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print(self.view.frame.origin.y)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return SproutTheme.current.preferredStatusBarStyle
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var plantPhotoDetail: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Views
    
    func setupViews() {
        view.backgroundColor = SproutTheme.current.backgroundColor
        
        plantPhotoDetail.image = plantPhoto
        plantPhotoDetail.isUserInteractionEnabled = true
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        //Make the date "pretty"
        //        navigationItem.title = "\(day!.plantType!.type!): \(day!.date!)"
    }
    
    // MARK: - Delegate Functions
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return plantPhotoDetail
    }
    
    // MARK: - Property
    
    var plantPhoto: UIImage?
}
