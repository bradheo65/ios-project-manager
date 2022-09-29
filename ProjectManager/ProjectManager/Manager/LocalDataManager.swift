//
//  LocalDataManager.swift
//  ProjectManager
//
//  Created by brad on 2022/09/29.
//

import Foundation
import RealmSwift

final class LocalDataManager {
    // MARK: - Properties
    
    private let realm = try? Realm()
    
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
    
    init() {
        fetch()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
}

// MARK: - CRUD

extension LocalDataManager: DataManagable {
    func fetch() {
        guard let todoResult = realm?.objects(RealmToDoItem.self) else { return }
        guard let doingResult = realm?.objects(RealmDoingItem.self) else { return }
        guard let doneResult = realm?.objects(RealmDoneItem.self) else { return }
        todoContent = Array(todoResult)
        doingContent = Array(doingResult)
        doneContent = Array(doneResult)
    }
    
    func read(from index: Int, of type: ProjectType) -> ToDoItem {
        switch type {
        case .todo:
            return todoContent.get(index: index) ?? RealmToDoItem()
        case .doing:
            return doingContent.get(index: index) ?? RealmToDoItem()
        case .done:
            return doneContent.get(index: index) ?? RealmToDoItem()
        }
    }
    
    func create(with item: ToDoItem, to type: ProjectType) {
        switch type {
        case .todo:
            let todo = RealmToDoItem()
            todo.update(with: item)
            
            do {
                try realm?.write {
                    realm?.add(todo)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            let todo = RealmDoingItem()
            todo.update(with: item)
            
            do {
                try realm?.write {
                    realm?.add(todo)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            let todo = RealmDoneItem()
            todo.update(with: item)
            
            do {
                try realm?.write {
                    realm?.add(todo)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        fetch()
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            do {
                try realm?.write {
                    todoContent[index].update(with: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            do {
                try realm?.write {
                    doingContent[index].update(with: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            do {
                try realm?.write {
                    doneContent[index].update(with: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        fetch()
    }
    
    func delete(index: Int, with type: ProjectType) {
        switch type {
        case .todo:
            do {
                try realm?.write {
                    realm?.delete(todoContent[index])
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            do {
                try realm?.write {
                    realm?.delete(doingContent[index])
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            do {
                try realm?.write {
                    realm?.delete(doneContent[index])
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        fetch()
    }
    
    func count(with type: ProjectType) -> Int {
        switch type {
        case .todo:
            return todoContent.count
        case .doing:
            return doingContent.count
        case .done:
            return doneContent.count
        }
    }
}
