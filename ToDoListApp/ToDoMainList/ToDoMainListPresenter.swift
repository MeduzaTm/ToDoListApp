//
//  ToDoMainListPresenter.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 21.03.2025.
//

class ToDoMainListPresenter: ToDoListPresenterProtocol, ToDoListInteractorOutputProtocol {
    
    var view: ToDoMainListViewProtocol?
    var interactor: ToDoListInteractorInputProtocol?
    var router: ToDoListRouterProtocol?
    
    private var cachedItems: [CDToDoItem] = []
    
    func viewDidLoad() {
        cachedItems = interactor?.fetchCachedToDoItems() ?? []
        
        if cachedItems.isEmpty {
            interactor?.fetchToDoList()
        } else {
            view?.showToDoItems(cachedItems)
        }
    }
    
    func didFetchToDoItems(_ items: [ToDoItem]) {
        interactor?.saveToDoItems(items)
        cachedItems = interactor?.fetchCachedToDoItems() ?? []
        view?.showToDoItems(cachedItems)
    }
    
    func didFailToFetchToDoItems(with error: String) {
        view?.showError(error)
    }
    
    func didFailToSaveToDoItems(with error: String) {
        view?.showError("Save failed: \(error)")
    }
    
    func deleteToDo(_ toDo: CDToDoItem) {
        interactor?.deleteToDo(toDo)
    }
    
    func numberOfTasks() -> Int {
        return cachedItems.count
    }
    
    func todo(at index: Int) -> CDToDoItem {
        return cachedItems[index]
    }
    
    func navigate() {
        router?.navigateToEditTask()
    }
}
