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
            guard let ciImage = CIImage(image: userPickedImage) else{
                fatalError("Could not convert into CIImage")
            }
            detect(image : ciImage)
        }
        imagePicker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image : CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("Loading CoreMLModel Model Failed!")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
        }
        let imageHandler = VNImageRequestHandler(ciImage : image)
        do{
            try imageHandler.perform([request])
        }catch{
            print("image handler error \(error)")
        }
        
    }

    @IBAction func cameraTabbed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
}

