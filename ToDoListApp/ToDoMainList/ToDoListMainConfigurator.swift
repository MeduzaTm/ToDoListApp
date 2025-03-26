//
//  ToDoListMainConfigurator.swift
//  ToDoApp
//
//  Created by Нурик  Генджалиев   on 21.03.2025.
//

import UIKit

class ToDoListMainConfigurator {
    
    static func configureView() -> UIViewController {
        let view = ToDoListMainViewController()
        let presenter = ToDoMainListPresenter()
        let interactor = ToDoMainListInteractor()
        let router = ToDoMainListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}
