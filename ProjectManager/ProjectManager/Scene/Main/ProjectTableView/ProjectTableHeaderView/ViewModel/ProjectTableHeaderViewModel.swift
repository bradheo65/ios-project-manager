//
//  ProjectTableHeaderViewModel.swift
//  ProjectManager
//
//  Created by brad on 2022/09/29.
//

import Foundation

final class ProjectTableHeaderViewModel {
    
    private let projectManager = ProjectDataManager()
    
    private var todoContent: [ToDoItem] = []
    private var doingContent: [ToDoItem] = []
    private var doneContent: [ToDoItem] = []
    
    init() { }
    
    // MARK: - Functions
    
    func fetch() {
        todoContent = projectManager.todoFetch()
        doingContent = projectManager.doingFetch()
        doneContent = projectManager.doneFetch()
    }
    
    func count(of type: ProjectType) -> Int {
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
