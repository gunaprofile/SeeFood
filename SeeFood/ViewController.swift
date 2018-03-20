//
//  ViewController.swift
//  SeeFood
//
//  Created by gunm on 20/03/18.
//  Copyright © 2018 Gunaseelan. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        //imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        imageView.backgroundColor = UIColor.lightGray
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = userPickedImage
            imageView.contentMode = .scaleAspectFill
        }
        imagePicker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        
    }

    @IBAction func cameraTabbed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
}

