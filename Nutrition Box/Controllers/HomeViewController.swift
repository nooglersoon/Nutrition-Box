//
//  ViewController.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 07/09/21.
//

import UIKit
import Vision
import CoreML

class HomeViewController: UIViewController {
    
    @IBOutlet weak var selectedImageLabel: UILabel!
    @IBOutlet weak var generateCardButton: UIButton!
    @IBOutlet weak var cameraImagePicker: UIButton!
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStateDefault()
    }
    
    @IBAction func cameraPickerTapped(_ sender: Any) {
        imagePickerTapped(.camera)
    }
    
    @IBAction func libraryPickerTapped(_ sender: Any) {
        imagePickerTapped(.photoLibrary)
    }
    
    @IBAction func generateCardTapped(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navigationVC = segue.destination as! UINavigationController
        if let nutritionCardVC = navigationVC.topViewController as? NutritionCardViewController{
            
            nutritionCardVC.navigationController?.title = selectedImageLabel.text
            nutritionCardVC.foodName = selectedImageLabel.text
            nutritionCardVC.dataController = dataController
        }
        
    }
    
    func setStateDefault(){
        
        // Check if the device has camera. Disabled the option if it hasn't
        cameraImagePicker.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        selectedImageLabel.text = "Select New Image"
        generateCardButton.isEnabled = false
        
    }

}

