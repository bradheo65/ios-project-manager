//
//  ItemListCategory.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/15.
//

import Foundation

struct ItemListCategory: Codable {
    
    // MARK: - Properties
    
    let todo: [RealmToDoItem]
    let doing: [RealmDoingItem]
    let done: [RealmDoneItem]
    
    // MARK: - Initializers
    
    init(todo: [RealmToDoItem] = [], doing: [RealmDoingItem] = [], done: [RealmDoneItem] = []) {
        self.todo = todo
        self.doing = doing
        self.done = done
    }
    
    // MARK: - CodingKey
    
    enum CodingKeys: String, CodingKey {
        case todo = "TODO"
        case doing = "DOING"
        case done = "DONE"
    }
}
