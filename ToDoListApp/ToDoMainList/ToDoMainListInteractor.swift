//
//  ToDoMainListInteractor.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 21.03.2025.
//

import Foundation
import CoreData

class ToDoMainListInteractor: ToDoListInteractorInputProtocol {
    func didDeleteToDo(_ todo: CDToDoItem) {
        presenter?.didFailToSaveToDoItems(with: "Deleted")
    }
    
    func didFailToDeleteToDo(_ todo: CDToDoItem) {
        presenter?.didFailToSaveToDoItems(with: "Not Deleted")
    }
    
    var presenter: ToDoListInteractorOutputProtocol?
    private let context = CoreDataManager.shared.context
    
    
    func fetchToDoList() {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            DispatchQueue.main.async {
                self.presenter?.didFailToFetchToDoItems(with: "Invalid URL")
            }
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.presenter?.didFailToFetchToDoItems(with: error.localizedDescription)
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.presenter?.didFailToFetchToDoItems(with: "No data received")
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ToDoResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.presenter?.didFetchToDoItems(response.todos)
                }
            } catch {
                DispatchQueue.main.async {
                    self?.presenter?.didFailToFetchToDoItems(with: error.localizedDescription)

                }
            }
        }.resume()
    }
    
    
    func saveToDoItems(_ items: [ToDoItem]) {
        let context = self.context
        context.perform { [weak self] in
            do {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDToDoItem.fetchRequest()
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try context.execute(deleteRequest)
                items.forEach { item in
                    let newItem = CDToDoItem(context: context)
                    newItem.update(from: item)
                }
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                self?.presenter?.didFailToSaveToDoItems(with: "Database error: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCachedToDoItems() -> [CDToDoItem] {
        let request: NSFetchRequest<CDToDoItem> = CDToDoItem.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteToDo(_ todo: CDToDoItem) {
        context.delete(todo)
        do {
            try context.save()
        }
        catch {
            fatalError()
        }
    }
    
    private func clearExistingData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CDToDoItem.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Failed to clear data:", error)
        }
    }
}
