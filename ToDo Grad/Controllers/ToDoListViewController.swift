//
//  ToDoListViewController.swift
//  ToDo Grad
//
//  Created by Konstantin on 09.05.2022.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    private var itemArray: [Item] = []
    
    private let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        loadItems()
        
    }
    
    // MARK: - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New ToDo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [weak self] action in
            guard let self = self else { return }
            
            guard let alertText = alert.textFields?.first?.text else { return }
            
            self.itemArray.append(Item(title: alertText))
            
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
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error emcoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    private func loadItems() {
        
        guard let data = try? Data(contentsOf: dataFilePath!) else { return }
        let decoder = PropertyListDecoder()
        do {
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item array, \(error)")
        }
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
        
        itemArray[indexPath.row].done.toggle()
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - Setup NavigationBar

extension ToDoListViewController {
    
    private func setupNavigationBar() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithOpaqueBackground()
        coloredAppearance.backgroundColor = .systemBlue
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = coloredAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = coloredAppearance

        navigationController?.navigationBar.tintColor = UIColor.white
    }
}