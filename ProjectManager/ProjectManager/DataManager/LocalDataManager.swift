//
//  LocalDataManager.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import RealmSwift

final class LocalDataManager: DataManagable {
    
    // MARK: - Properties
    
    private let realm = try? Realm()
    
    var todoList: [RealmToDoItem] = [] {
        didSet {
            todoListener?(todoList)
        }
    }

    var doingList: [RealmDoingItem] = [] {
        didSet {
            doingListener?(doingList)
        }
    }

    var doneList: [RealmDoneItem] = [] {
        didSet {
            doneListener?(doneList)
        }
    }
    
    private var todoListener: (([RealmToDoItem]) -> Void)?
    private var doingListener: (([RealmDoingItem]) -> Void)?
    private var doneListener: (([RealmDoneItem]) -> Void)?
    
    // MARK: - Initializers

    init() {
        read()
    }
    
    // MARK: - Functions
    
    func todoSubscripting(listener: @escaping ([RealmToDoItem]) -> Void) {
        listener(todoList)
        self.todoListener = listener
    }

    func doingSubscripting(listener: @escaping ([RealmDoingItem]) -> Void) {
        listener(doingList)
        self.doingListener = listener
    }

    func doneSubscripting(listener: @escaping ([RealmDoneItem]) -> Void) {
        listener(doneList)
        self.doneListener = listener
    }
    
    // MARK: - CRUD
    
    func read() {
        guard let todoResult = realm?.objects(RealmToDoItem.self) else { return }
        guard let doingResult = realm?.objects(RealmDoingItem.self) else { return }
        guard let doneResult = realm?.objects(RealmDoneItem.self) else { return }
        todoList = Array(todoResult)
        doingList = Array(doingResult)
        doneList = Array(doneResult)
    }
    
    func read(from index: Int, of type: ProjectType) -> ToDoItem {
        switch type {
        case .todo:
            return todoList.get(index: index) ?? RealmToDoItem()
        case .doing:
            return doingList.get(index: index) ?? RealmToDoItem()
        case .done:
            return doneList.get(index: index) ?? RealmToDoItem()
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
        read()
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            do {
                try realm?.write {
                    todoList[index].update(with: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            do {
                try realm?.write {
                    doingList[index].update(with: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            do {
                try realm?.write {
                    doneList[index].update(with: item)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        read()
    }
    
    func delete(index: Int, with type: ProjectType) {
        switch type {
        case .todo:
            do {
                try realm?.write {
                    realm?.delete(todoList[index])
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            do {
                try realm?.write {
                    realm?.delete(doingList[index])
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            do {
                try realm?.write {
                    realm?.delete(doneList[index])
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        read()
    }
    
    func count(with type: ProjectType) -> Int {
        switch type {
        case .todo:
            return todoList.count
        case .doing:
            return doingList.count
        case .done:
            return doneList.count
        }
    }
}
