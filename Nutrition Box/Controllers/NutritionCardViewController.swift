//
//  NutritionCardViewController.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import UIKit

class NutritionCardViewController: UIViewController {
    
    var foodName: String!
    var foodImg: UIImage!
    
    var dataController: DataController!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var weightsLabel: UILabel!
    @IBOutlet weak var dietLabels: UILabel!
    @IBOutlet weak var healthLabels: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        fetchNutritionAnalysis(foodName)
        setStateDefault()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = foodName
    }
    
    func setStateDefault(){
        
        caloriesLabel.text = "0 ccal"
        weightsLabel.text = "0 g"
        dietLabels.text = "..."
        healthLabels.text = "..."
        
    }
    
    @IBAction func addToFavoriteTapped(_ sender: Any) {
        
        let favoriteFood = FavoriteFood(context:dataController.viewContext)
        favoriteFood.foodName = foodName
        favoriteFood.calorie = caloriesLabel.text
        favoriteFood.weight = weightsLabel.text
        favoriteFood.diet = dietLabels.text
        favoriteFood.health = healthLabels.text
        try? dataController.viewContext.save()
        
        dismiss(animated: true, completion: nil)
            
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func fetchNutritionAnalysis(_ foodname: String){
        
        EdamamClient.getNutrionAnalysis(foodParam: foodName, completion: nutritionAnalysisHandler(responseCode:responseObj:error:))
        
    }
    
    private func nutritionAnalysisHandler(responseCode: EdamamResponseCode?, responseObj: EdamamResponse?, error: Error?){
        
        if error == nil {
            
            guard let response = responseObj else {
                return
            }
            
            self.activityIndicator.stopAnimating()
            
            caloriesLabel.text = "\(response.calories) ccal"
            weightsLabel.text = "\(response.totalWeight) g"
            dietLabels.text = "\(response.dietLabels.first ?? "-")"
            healthLabels.text = "\(response.healthLabels.first ?? "-")"
            
        } else {
            
            showAlert(title: "Error Fetching Data", message: "Check your Connection")
            
        }
        
    }
    
    private func showAlert(title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }

}
