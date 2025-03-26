//
//  CDToDoItem+CoreDataProperties.swift
//  ToDoListApp
//
//  Created by Нурик  Генджалиев   on 26.03.2025.
//
//

import Foundation
import CoreData


extension CDToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDToDoItem> {
        return NSFetchRequest<CDToDoItem>(entityName: "CDToDoItem")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var toDoItem: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var userId: UUID?

}

extension CDToDoItem : Identifiable {
    func update(from item: ToDoItem) {
        self.id = item.id.toUUID()
        self.title = item.toDoItem.prefix(20).description
        self.toDoItem = item.toDoItem
        self.completed = item.completed
        self.userId = item.id.toUUID()
        self.creationDate = Date()
    }
}
