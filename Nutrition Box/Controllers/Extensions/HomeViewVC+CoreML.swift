//
//  HomeViewVC+CoreML.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import Foundation
import CoreML
import Vision
import UIKit

extension HomeViewController {
    
    func imageDetection(image: CIImage, completion: @escaping ()->Void) {
        
        // Load Model
        
        let config = MLModelConfiguration()
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: config).model) else {
            fatalError("Loading coreML Model Failed.")
        }
        
        // Set request handler
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Make request image to analyze
        
        let request = VNCoreMLRequest(model: model) { [self] (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation],
                        let topResult = results.first else {
                            fatalError("Unexpected result")
                    }
            
            print("Label: \(topResult.identifier.description.split(separator: ",")[0]) with confidence level: \(topResult.confidence)")
            
            let label = String(topResult.identifier.description.split(separator: ",")[0]).uppercased()
            
            DispatchQueue.main.async {
                self.selectedImageLabel.text = label
            }
            
        }
        
        do {
           try handler.perform([request])
            completion()

        } catch {
            print(error)
        }
        
        
    }
    
}
