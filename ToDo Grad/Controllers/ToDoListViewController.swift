//
//  ToDoListViewController.swift
//  ToDo Grad
//
//  Created by Konstantin on 09.05.2022.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    private var itemArray: [Item] = []
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
//        setupNavigationBar()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadItems()
        
    }
    
    // MARK: - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            guard let alertText = alert.textFields?.first?.text else { return }
            
            let newItem = Item(context: self.context)
            newItem.title = alertText
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
}

// MARK: - Model Manupulation Method

extension ToDoListViewController {
    
    private func saveItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    private func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
}

// MARK: - UITableViewDataSource

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        let item = itemArray[indexPath.row]

        content.text = item.title
        cell.accessoryType = item.done == true ? .checkmark : .none

        cell.contentConfiguration = content
         
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done.toggle()
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - UISearchBarDelegate

extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchBar.text!.isEmpty else {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            return
        }
    }
    
}
