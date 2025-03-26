//
//  ToDoItem.swift
//  ToDoListApp
//
//  Created by Нурик  Генджалиев   on 26.03.2025.
//


import Foundation

struct ToDoItem: Identifiable, Equatable, Codable {
    let id: Int
    let toDoItem: String
    let completed: Bool
    let userId: Int 
    var title: String {
        return String(toDoItem.prefix(20))
    }
    var creationDate: Date? {
        return Date()
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case toDoItem = "todo"
        case completed
        case userId
    }
}

struct ToDoResponse: Codable {
    let todos: [ToDoItem]
    let total: Int
    let skip: Int
    let limit: Int
}
