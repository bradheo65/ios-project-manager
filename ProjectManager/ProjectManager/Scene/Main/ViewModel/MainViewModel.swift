//
//  MainViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

final class MainViewModel {
    
    // MARK: - Singletone

    private let projectManager = ProjectDataManager()
    
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
    
    init() {
        projectManager.binding()
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
    
    func binding() {
        projectManager.todoSubscripting { _ in
            self.fetch()
        }
        
        projectManager.doingSubscripting { _ in
            self.fetch()
        }
        
        projectManager.doneSubscripting { _ in
            self.fetch()
        }
    }
    
    func fetch() {
        todoContent = projectManager.todoFetch()
        doingContent = projectManager.doingFetch()
        doneContent = projectManager.doneFetch()
    }
    
}
