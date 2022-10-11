//
//  ProjectDataManager.swift
//  ProjectManager
//
//  Created by brad on 2022/10/11.
//

import Foundation

final class ProjectDataManager {
    
    // MARK: - Singletone
    
    private let dataManager = LocalDataManager.shared

    var todoContent: [ToDoItem] = [] {
        didSet {
            todoListener?(todoContent)
        }
    }
    
    var doingContent: [ToDoItem] = [] {
        didSet {
            doingListener?(doingContent)
        }
    }
    
    var doneContent: [ToDoItem] = [] {
        didSet {
            doneListener?(doneContent)
        }
    }
    
    private var todoListener: (([ToDoItem]) -> Void)?
    private var doingListener: (([ToDoItem]) -> Void)?
    private var doneListener: (([ToDoItem]) -> Void)?

    // MARK: - Functions
    
    func todoSubscripting(listener: @escaping ([ToDoItem]) -> Void) {
        listener(todoContent)
        self.todoListener = listener
    }
    
    func doingSubscripting(listener: @escaping ([ToDoItem]) -> Void) {
        listener(doingContent)
        self.doingListener = listener
    }
    
    func doneSubscripting(listener: @escaping ([ToDoItem]) -> Void) {
        listener(doneContent)
        self.doneListener = listener
    }
    
    func binding() {
        dataManager.todoSubscripting { [weak self] _ in
            self?.fetch()
        }
        dataManager.doingSubscripting { [weak self] _ in
            self?.fetch()
        }
        dataManager.doneSubscripting { [weak self] _ in
            self?.fetch()
        }
    }
    
    func fetch() {
        todoContent = dataManager.todoFetch()
        doingContent = dataManager.doingFetch()
        doneContent = dataManager.doneFetch()
    }
    
    func todoFetch() -> [ToDoItem] {
        return dataManager.todoFetch()
    }
    
    func doingFetch() -> [ToDoItem] {
        return dataManager.doingFetch()
    }
    
    func doneFetch() -> [ToDoItem] {
        return dataManager.doneFetch()
    }
}

extension ProjectDataManager: DataManager {
    
    func create(new item: ToDoItem, to type: ProjectType) {
        dataManager.create(new: item, to: type)

        fetch()
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        dataManager.update(item: item, from: index, of: type)

        fetch()
    }
    
    func delete(item: ToDoItem, of type: ProjectType) {
        dataManager.delete(item: item, of: type)

        fetch()
    }
    
    func move(item: ToDoItem, project: ProjectType, to anotherProject: ProjectType) {
        dataManager.move(item: item, project: project, to: anotherProject)

        fetch()
    }
}
