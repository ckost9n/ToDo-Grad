//
//  CategoryViewController.swift
//  ToDo Grad
//
//  Created by Konstantin on 16.05.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    private var categoryArray: [Category] = []
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setupNavigationBar()
        
        
        
        loadCategories()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            guard let alertText = alert.textFields?.first?.text else { return }
            
            let newCategory = Category(context: self.context)
            newCategory.name = alertText
            
            self.categoryArray.append(newCategory)
            self.saveCategories()
            
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Category"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let category = categoryArray[indexPath.row]
        
        content.text = category.name

        cell.contentConfiguration = content

        return cell
    }
    
}

// MARK: - Model Manupulation Method

extension CategoryViewController {
    
    private func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    private func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}
