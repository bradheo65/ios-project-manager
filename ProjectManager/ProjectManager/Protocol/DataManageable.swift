//
//  DataManageable.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/29.
//

protocol DataManager {
    func create(new item: ToDoItem, to type: ProjectType)
    func update(item: ToDoItem, from index: Int, of type: ProjectType)
    func delete(item: ToDoItem, of type: ProjectType)
    func move(item: ToDoItem, project: ProjectType, to anotherProject: ProjectType)
}
