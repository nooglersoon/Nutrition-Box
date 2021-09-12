//
//  FavoriteFoodListViewController.swift
//  Nutrition Box
//
//  Created by Fauzi Achmad B D on 11/09/21.
//

import UIKit
import CoreData

class FavoriteFoodListViewController: UITableViewController {
    
    var dataController: DataController!
    
    var fetchedResultsController:NSFetchedResultsController<FavoriteFood>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // tableView.reloadData()
        setupFetchedResultsController()
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: false)
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fetchedResultsController = nil
    }
    
    fileprivate func setupFetchedResultsController() {
       
        if fetchedResultsController == nil {
            let fetchRequest:NSFetchRequest<FavoriteFood> = FavoriteFood.fetchRequest()
            let sortDescriptor = NSSortDescriptor(key: "foodName", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataController.viewContext, sectionNameKeyPath: nil, cacheName: "favoriteFood")
            fetchedResultsController.delegate = self
        }
        
        do {
            try fetchedResultsController.performFetch()
            tableView.reloadData()
        } catch {
            fatalError("The fetch could not be performed: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Table view data manipulation
    
    // Deletes the notebook at the specified index path
    func deleteFavoriteFood(at indexPath: IndexPath) {
        let foodToDelete = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(foodToDelete)
        try? dataController.viewContext.save()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let fetchedResultsController = fetchedResultsController {
            return fetchedResultsController.sections?.count ?? 0
        } else {
            return 0
        }
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "food", for: indexPath) as! FoodTableViewCell
        
        // Configure cell
        cell.foodNameLabel.text = food.foodName
        cell.calorieLabel.text = food.calorie
        cell.dietLabel.text = food.diet
        cell.healthLabel.text = food.health
        cell.weightLabel.text = food.weight
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete: deleteFavoriteFood(at: indexPath)
        default: () // Unsupported
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }

    
}

extension FavoriteFoodListViewController: NSFetchedResultsControllerDelegate {
    
    
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//
//        let indexPath = IndexPath(row: 0, section: sectionIndex)
//        tableView.insertRows(at: [indexPath], with: .fade)
//    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        default:
            break
        }
    }
    
}


