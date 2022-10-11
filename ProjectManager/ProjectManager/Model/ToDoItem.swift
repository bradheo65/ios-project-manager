//
//  ToDoItem.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/19.
//

import Foundation
import RealmSwift

class ToDoItem: Object, Codable {
    
    // MARK: - Properties
    
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var todoDescription: String = ""
    @objc dynamic var timeLimit: Date = Date()
    
    override init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.todoDescription = try container.decode(String.self, forKey: .todoDescription)
        self.timeLimit = try container.decode(Date.self, forKey: .timeLimit)
    }
}

final class RealmToDoItem: ToDoItem { }

final class RealmDoingItem: ToDoItem { }

final class RealmDoneItem: ToDoItem { }

extension ToDoItem {
    func append(with item: ToDoItem) {
        self.uuid = item.uuid
        self.title = item.title
        self.todoDescription = item.todoDescription
        self.timeLimit = item.timeLimit
    }
    
    func update(with item: ToDoItem) {
        self.uuid = item.uuid
        self.title = item.title
        self.todoDescription = item.todoDescription
        self.timeLimit = item.timeLimit
    }
}
