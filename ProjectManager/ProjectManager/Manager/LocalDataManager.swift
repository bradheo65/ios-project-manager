//
//  LocalDataManager.swift
//  ProjectManager
//
//  Created by brad on 2022/10/11.
//

import Foundation
import RealmSwift

final class LocalDataManager {
    
    // MARK: - Properties
    
    static let shared = LocalDataManager()
    private var realm: Realm
    
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
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        fetch()
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
        todoContent = Array(realm.objects(RealmToDoItem.self))
        doingContent = Array(realm.objects(RealmDoingItem.self))
        doneContent = Array(realm.objects(RealmDoneItem.self))
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

extension LocalDataManager: DataManager {
    
    // MARK: - Functions

    func create(new item: ToDoItem, to type: ProjectType) {
        switch type {
            
        case .todo:
            let todo = RealmToDoItem()
            
            todo.uuid = item.uuid
            todo.title = item.title
            todo.todoDescription = item.todoDescription
            todo.timeLimit = item.timeLimit

            try? realm.write {
                realm.add(todo)
            }
      
        case .doing:
            let doing = RealmDoingItem()
            
            doing.uuid = item.uuid
            doing.title = item.title
            doing.todoDescription = item.todoDescription
            doing.timeLimit = item.timeLimit
            
            try? realm.write {
                realm.add(doing)
            }
        case .done:
            let done = RealmDoneItem()
            
            done.uuid = item.uuid
            done.title = item.title
            done.todoDescription = item.todoDescription
            done.timeLimit = item.timeLimit
            
            try? realm.write {
                realm.add(done)
            }
        }
        fetch()
    }

    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            let updateToDo = realm.objects(RealmToDoItem.self)

            try? realm.write {

                item.uuid = updateToDo[index].uuid
                updateToDo[index].title = item.title
                updateToDo[index].todoDescription = item.todoDescription
                updateToDo[index].timeLimit = item.timeLimit
            }

        case .doing:
            let updateDoing = realm.objects(RealmDoingItem.self)

            try? realm.write {
                item.uuid = updateDoing[index].uuid
                updateDoing[index].title = item.title
                updateDoing[index].todoDescription = item.todoDescription
                updateDoing[index].timeLimit = item.timeLimit
            }
        case .done:
            let updateDone = realm.objects(RealmDoneItem.self)

            try? realm.write {
                item.uuid = updateDone[index].uuid
                updateDone[index].title = item.title
                updateDone[index].todoDescription = item.todoDescription
                updateDone[index].timeLimit = item.timeLimit
            }
        }
        fetch()
    }
    
    func delete(item: ToDoItem, of type: ProjectType) {
        switch type {
        case .todo:
            try? realm.write {
                let predicate = NSPredicate(format: "uuid = %@",
                                            item.uuid as CVarArg)
                realm.delete(realm.objects(RealmToDoItem.self).filter(predicate))
                
                fetch()
            }
        case .doing:
            try? realm.write {
                let predicate = NSPredicate(format: "uuid = %@",
                                            item.uuid as CVarArg)
                realm.delete(realm.objects(RealmDoingItem.self).filter(predicate))
                
                fetch()
            }
        case .done:
            try? realm.write {
                let predicate = NSPredicate(format: "uuid = %@",
                                            item.uuid as CVarArg)
                realm.delete(realm.objects(RealmDoneItem.self).filter(predicate))
                
                fetch()
            }
        }
    }
    
    func move(item: ToDoItem, project: ProjectType, to anotherProject: ProjectType) {
        
        create(new: item, to: anotherProject)
        delete(item: item, of: project)
        fetch()
    }
}
