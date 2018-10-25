//
//  PhotoDetailViewController.swift
//  Sprout
//
//  Created by Kainoa Palama on 4/19/18.
//  Copyright © 2018 Kainoa Palama. All rights reserved.
//

//Make imageView "zoomable" with scrollview and a delegate

import UIKit

class PhotoDetailViewController: UIViewController{
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plantPhotoDetail.image = plantPhoto
    }
    
    // MARK: - Outlet
    
    @IBOutlet weak var plantPhotoDetail: UIImageView!

    // MARK: - Property
    
    var plantPhoto: UIImage?
}
