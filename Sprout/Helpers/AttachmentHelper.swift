//
//  AttachmentHelper.swift
//  Sprout
//
//  Created by Kainoa Palama on 2/22/19.
//  Copyright © 2019 Kainoa Palama. All rights reserved.
//

import Photos

class AttachmentHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let shared = AttachmentHelper()
    
    func presentAttachmentActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: "Select Image Location", message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (_) in
                self.requestAttachmentAuthorizationStatus(attachmentType: .camera)
            }))
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (_) in
                self.requestAttachmentAuthorizationStatus(attachmentType: .photoLibrary)
            }))
        }
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    func requestAttachmentAuthorizationStatus(attachmentType: AttachmentType) {
        if attachmentType == AttachmentType.camera {
            checkCameraAuthorizationStatus()
        } else if attachmentType == AttachmentType.photoLibrary {
            checkPhotoLibraryAuthorizationStatus()
        }
    }
    
    func checkCameraAuthorizationStatus() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            print("Open attachment")
            presentImagePicker(attachmentType: .camera)
            
        case .notDetermined:
            print("Ask for permission")
            AVCaptureDevice.requestAccess(for: .video) { (allowed) in
                if allowed == true {
                    //Ask for photoLibrary
                    self.presentImagePicker(attachmentType: AttachmentType.camera)
                } else if allowed == false {
                    //Ask for photoLibrary
                    return
                }
            }
        case .denied:
            presentPermissionAlert(attachmentType: .camera)
            
        default:
            return
        }
    }
    
    func checkPhotoLibraryAuthorizationStatus(){
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            presentImagePicker(attachmentType: .photoLibrary)
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == PHAuthorizationStatus.authorized {
                    //Ask for camera
                    self.presentImagePicker(attachmentType: AttachmentType.photoLibrary)
                } else if status == PHAuthorizationStatus.denied {
                    //Ask for camera
                    return
                }
            }
            
        case .denied:
            presentPermissionAlert(attachmentType: .photoLibrary)
            
        default:
            return
        }
    }
    
    func presentImagePicker(attachmentType: AttachmentType) {
        guard let currentVC = currentVC else {return}
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if attachmentType == .camera {
            imagePicker.sourceType = .camera
        } else if attachmentType == .photoLibrary {
            imagePicker.sourceType = .photoLibrary
        }
        
        currentVC.present(imagePicker, animated: true, completion: nil)
    }
    
    func presentPermissionAlert(attachmentType: AttachmentType) {
        
        var alertTitle: String {
            var string: String = ""
            if attachmentType == AttachmentType.camera {
                string = "Sprout does not have access to your Camera. To enable access, tap Settings."
            } else if attachmentType == AttachmentType.photoLibrary {
                string = "Sprout does not have access to your Photo Library. To enable access, tap Settings."
            }
            return string
        }
        
        let alert = UIAlertController(title: "Access Denied", message: alertTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {return}
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }))
        currentVC?.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delegatation
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.imagePicked?(image)
        } else {
            print("Error converting UIImagePickerControllerInfo to image")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    enum AttachmentType {
        case camera
        case photoLibrary
    }
    
    var currentVC: UIViewController?
    var imagePicked: ((UIImage) -> Void)?
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
}

