//
//  ToDoMainListProtocols.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 22.03.2025.
//

protocol ToDoMainListViewProtocol: AnyObject {
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
}

// MARK: - Interactor Protocol
protocol ToDoListInteractorInputProtocol: AnyObject {
    func fetchToDoList()
    func saveToDoItems(_ items: [ToDoItem])
    func fetchCachedToDoItems() -> [CDToDoItem]
    func deleteToDo(at index: Int)
    func didDeleteToDo(at index: Int)
    func didFailToDeleteToDo(at index: Int)
}

// MARK: - Router Protocol
protocol ToDoListRouterProtocol: AnyObject {
    func navigateToEditTask()
}
