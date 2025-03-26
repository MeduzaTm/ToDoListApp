//
//  ToDoMainListPresenter.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 21.03.2025.
//

import Foundation

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
    
    func deleteToDo(at index: Int) {
        guard index < cachedItems.count else { return }
        let item = cachedItems[index]
        interactor?.deleteToDo(item)
    }
    
    func didDeleteItem(_ item: CDToDoItem) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard let index = self.cachedItems.firstIndex(where: { $0.id == item.id }) else {
                self.view?.showError("Элемент не найден")
                return
            }
            self.cachedItems.remove(at: index)
            self.view?.showDeleteSuccess(at: index)
        }
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
    
    func didFailToDeleteItem(error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showError(error.localizedDescription)
        }
    }
    
}
