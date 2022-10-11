//
//  FakeToDoItemManager.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/10.
//

import Foundation

final class FakeDataManager {
    
    // MARK: - Properties
    
    static let shared = FakeDataManager()
    private var fakeService = FakeService()

    // MARK: - Properties
    
    private var todoContent: [ToDoItem] = [] {
        didSet {
            todoListener?(todoContent)
        }
    }
    
    private var doingContent: [ToDoItem] = [] {
        didSet {
            doingListener?(doingContent)
        }
    }
    
    private var doneContent: [ToDoItem] = [] {
        didSet {
            doneListener?(doneContent)
        }
    }
    
    private var todoListener: (([ToDoItem]) -> Void)?
    private var doingListener: (([ToDoItem]) -> Void)?
    private var doneListener: (([ToDoItem]) -> Void)?
    
    // MARK: - Initializers
    
    private init() {
        // fetch()
    }
    
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
    
    func fetch() {
        todoContent = fakeService.loadData().todo
        doingContent = fakeService.loadData().doing
        doneContent = fakeService.loadData().done
    }
    
    func todoFetch() -> [ToDoItem] {
        return todoContent
    }
    
    func doingFetch() -> [ToDoItem] {
        return doingContent
    }
    
    func doneFetch() -> [ToDoItem] {
        return doneContent
    }
}

extension FakeDataManager: DataManager {
 
    func create(new item: ToDoItem, to type: ProjectType) {
        switch type {
        case .todo:
            todoContent.append(item)
        case .doing:
            doingContent.append(item)
        case .done:
            doneContent.append(item)
        }
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            todoContent[index] = item
        case .doing:
            doingContent[index] = item
        case .done:
            doneContent[index] = item
        }
    }
    
    func delete(item: ToDoItem, of type: ProjectType) {
        switch type {
        case .todo:
            todoContent.removeAll(where: { $0.uuid == item.uuid })
        case .doing:
            todoContent.removeAll(where: { $0.uuid == item.uuid })
        case .done:
            todoContent.removeAll(where: { $0.uuid == item.uuid })
        }
    }
    
    func move(item: ToDoItem, project: ProjectType, to anotherProject: ProjectType) {
        
        create(new: item, to: anotherProject)
        delete(item: item, of: project)
    }
}
