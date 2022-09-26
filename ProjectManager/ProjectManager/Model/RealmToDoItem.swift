//
//  RealmToDoItem.swift
//  ProjectManager
//
//  Created by bard on 2022/09/25.
//

import Foundation
import RealmSwift

class RealmToDoItem: Object {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var toDoDescription: String = ""
    @objc dynamic var timeLimit: Date = Date()
}

final class RealmDoingItem: RealmToDoItem { }

final class RealmDoneItem: RealmToDoItem { }

extension RealmToDoItem {
    func update(with item: RealmToDoItem) {
        self.title = item.title
        self.toDoDescription = item.toDoDescription
        self.timeLimit = item.timeLimit
    }
}
