//
//  RealmToDoItem.swift
//  ProjectManager
//
//  Created by bard on 2022/09/25.
//

import Foundation
import RealmSwift

final class RealmToDoItem: Object {
    @objc dynamic var uuid: UUID = UUID()
    @objc dynamic var title: String = ""
    @objc dynamic var toDoDescription: String = ""
    @objc dynamic var timeLimit: Date = Date()
}
