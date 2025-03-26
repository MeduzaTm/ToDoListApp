//
//  ViewController.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 21.03.2025.
//

import UIKit

class ToDoListMainViewController: UITableViewController, ToDoMainListViewProtocol  {
    var presenter: ToDoListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    func showToDoItems(_ items: [CDToDoItem]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ToDoMainListViewCell.self, forCellReuseIdentifier: "ToDoMainViewCell")
        
        navigationItem.title = "ToDoApp"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController(searchResultsController: nil)
    }
}

extension ToDoListMainViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfTasks() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoMainViewCell", for: indexPath) as! ToDoMainListViewCell
        guard let todo = presenter?.todo(at: indexPath.row) else { return cell }
        cell.configure(with: todo)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let todo = presenter?.todo(at: indexPath.row) else { return nil}
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            let editAction = UIAction(title: "Редактировать", image: UIImage(systemName: "pencil")) { action in
                self.presenter?.navigate()
            }
            
            let shareAction = UIAction(title: "Поделиться", image: UIImage(systemName: "square.and.arrow.up")) { action in
                //                self.shareTask(at: indexPath)
            }
            
            let deleteAction = UIAction(title: "Удалить", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                self.presenter?.deleteToDo(todo)
                tableView.reloadData()
            }

            return UIMenu(title: "", children: [editAction, shareAction, deleteAction])
        }
    }
}


