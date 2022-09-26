//
//  LocalDataManager.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import RealmSwift

final class MainViewModel {
    
    // MARK: - Properties
    
    let localDatManager = LocalDataManager.shared
    
//    lazy var sample = localDatManager.read(with: <#T##[RealmToDoItem]#>)
    
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
        localDatManager.read()
    }
    
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
}

final class LocalDataManager {
    
    // MARK: - Singletone
    
    static let shared = LocalDataManager()
    
    // MARK: - Properties
    
    private let realm = try? Realm()
    
    var todoList: [RealmToDoItem] = []

    var doingList: [RealmDoingItem] = []

    var doneList: [RealmDoneItem] = []
    
//    private var todoListener: (([RealmToDoItem]) -> Void)?
//    private var doingListener: (([RealmDoingItem]) -> Void)?
//    private var doneListener: (([RealmDoneItem]) -> Void)?
    
    // MARK: - Initializers

    private init() {
        read()
    }
    
    // MARK: - Functions
    
//    func todoSubscripting(listener: @escaping ([RealmToDoItem]) -> Void) {
//        listener(todoList)
//        self.todoListener = listener
//    }
//
//    func doingSubscripting(listener: @escaping ([RealmDoingItem]) -> Void) {
//        listener(doingList)
//        self.doingListener = listener
//    }
//
//    func doneSubscripting(listener: @escaping ([RealmDoneItem]) -> Void) {
//        listener(doneList)
//        self.doneListener = listener
//    }
    
    // MARK: - CRUD
    
    // read
    func read() {
        guard let todoResult = realm?.objects(RealmToDoItem.self) else { return }
        guard let doingResult = realm?.objects(RealmDoingItem.self) else { return }
        guard let doneResult = realm?.objects(RealmDoneItem.self) else { return }
        todoList = Array(todoResult)
        doingList = Array(doingResult)
        doneList = Array(doneResult)
    }
    
    func read(with item: [RealmToDoItem]) -> [RealmToDoItem] {
        guard let result = realm?.objects(RealmToDoItem.self) else { return [] }
        todoList = Array(result)
        
        return todoList
    }
    
    // create
    func create(with item: RealmToDoItem, with type: ProjectType) {
        switch type {
        case .todo:
            let todo = RealmToDoItem()
            todo.update(with: item)
            
            do {
                try realm?.write {
                    realm?.add(todo)
                    read()
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
                    read()
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
                    read()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // update
    
    func update(item: RealmToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            do {
                try realm?.write {
                    todoList[index].update(with: item)
                    read()
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            do {
                try realm?.write {
                    doingList[index].update(with: item)
                    read()
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            do {
                try realm?.write {
                    doneList[index].update(with: item)
                    read()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // delete
    
    func delete(index: Int, with type: ProjectType) {
        switch type {
        case .todo:
            do {
                try realm?.write {
                    realm?.delete(todoList[index])
                    todoList.remove(at: index)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .doing:
            do {
                try realm?.write {
                    realm?.delete(doingList[index])
                    doingList.remove(at: index)
                }
            } catch {
                print(error.localizedDescription)
            }
        case .done:
            do {
                try realm?.write {
                    realm?.delete(doneList[index])
                    doneList.remove(at: index)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func count(with type: ProjectType) -> Int {
        switch type {
        case .todo:
            let todoList = [realm?.objects(RealmToDoItem.self)]
            
            return todoList.count
        case .doing:
            let doingList = [realm?.objects(RealmDoingItem.self)]
            
            return doingList.count
        case .done:
            let doneList = [realm?.objects(RealmDoneItem.self)]
            
            return doneList.count
        }
    }
}
