//
//  HomeViewVC+UIImagePickerDelegate.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import Foundation
import UIKit

extension HomeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerTapped(_ source: UIImagePickerController.SourceType) {
        
        let controller = UIImagePickerController()
        controller.allowsEditing = true
        controller.sourceType = source
        controller.delegate = self
        present(controller, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Processing the Machine Learning to Identify The Object
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            // Convert UIImage to CIImage
            
            guard let ciImage = CIImage(image: userPickedImage) else{
                fatalError("Cannot convert UIImage to CIImage")
            }
            
            imageDetection(image: ciImage){
                
                self.dismiss(animated: true, completion: nil)
                self.generateCardButton.isEnabled = true

            }
            
            
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        
        dismiss(animated: true, completion: nil)
        
    }

    
}

