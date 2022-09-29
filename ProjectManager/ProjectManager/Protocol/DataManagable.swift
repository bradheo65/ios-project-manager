//
//  DataManagable.swift
//  ProjectManager
//
//  Created by bard on 2022/09/28.
//

protocol DataManagable {
    func read()
    func create(with item: ToDoItem, to type: ProjectType)
    func update(item: ToDoItem, from index: Int, of type: ProjectType)
    func delete(index: Int, with type: ProjectType)
    func count(with type: ProjectType) -> Int
    func read(from index: Int, of type: ProjectType) -> ToDoItem
}
