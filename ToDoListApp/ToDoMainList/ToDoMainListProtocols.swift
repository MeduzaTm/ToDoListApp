//
//  ToDoMainListProtocols.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 22.03.2025.
//

protocol ToDoMainListViewProtocol: AnyObject {
    func showDeleteSuccess(at index: Int)
    func showToDoItems(_ items: [CDToDoItem])
    func showError(_ message: String)
}

// MARK: - Presenter Protocols
protocol ToDoListPresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfTasks() -> Int
    func todo(at index: Int) -> CDToDoItem
    func navigate()
    func deleteToDo(at index: Int)
}

protocol ToDoListInteractorOutputProtocol: AnyObject {
    func didFetchToDoItems(_ items: [ToDoItem])
    func didFailToFetchToDoItems(with error: String)
    func didFailToSaveToDoItems(with error: String)
    func didDeleteItem(_ item: CDToDoItem)
    func didFailToDeleteItem(error: Error)
}

// MARK: - Interactor Protocol
protocol ToDoListInteractorInputProtocol: AnyObject {
    func fetchToDoList()
    func saveToDoItems(_ items: [ToDoItem])
    func fetchCachedToDoItems() -> [CDToDoItem]
    func deleteToDo(_ todo: CDToDoItem)
}

// MARK: - Router Protocol
protocol ToDoListRouterProtocol: AnyObject {
    func navigateToEditTask()
}
