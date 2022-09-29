//
//  RealmToDoItem.swift
//  ProjectManager
//
//  Created by bard on 2022/09/25.
//

import Foundation
import RealmSwift

class ToDoItem: Object, Codable {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var toDoDescription: String = ""
    @objc dynamic var timeLimit: Date = Date()
    
    override init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.toDoDescription = try container.decode(String.self, forKey: .toDoDescription)
        self.timeLimit = try container.decode(Date.self, forKey: .timeLimit)
    }
    
    private enum CodingKeys: CodingKey {
            case title
            case toDoDescription
            case timeLimit
        }
}

class RealmToDoItem: ToDoItem { }

final class RealmDoingItem: ToDoItem { }

final class RealmDoneItem: ToDoItem { }

extension ToDoItem {
    func update(with item: ToDoItem) {
        self.title = item.title
        self.toDoDescription = item.toDoDescription
        self.timeLimit = item.timeLimit
    }
}
