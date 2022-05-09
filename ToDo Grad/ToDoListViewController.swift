//
//  ToDoListViewController.swift
//  ToDo Grad
//
//  Created by Konstantin on 09.05.2022.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    private let itemArray = ["Find Mike", "Buy Eggos", "Destory Demogorgon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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

        content.text = itemArray[indexPath.row]

        cell.contentConfiguration = content
         
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension ToDoListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        let cellType = cell.accessoryType
        
        cell.accessoryType = cellType == .none ? .checkmark : .none
        
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
