//
//  ProjectTableViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

final class ProjectTableViewModel {
    
    // MARK: - Properties
    
    private let projectDataManager = ProjectDataManager()

    private var todoContent: [ToDoItem] = []
    private var doingContent: [ToDoItem] = []
    private var doneContent: [ToDoItem] = []

    // MARK: - Functions
    
    func fetch() {
        self.todoContent = projectDataManager.todoFetch()
        self.doingContent = projectDataManager.doingFetch()
        self.doneContent = projectDataManager.doneFetch()
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

    func searchContent(from index: Int, of type: ProjectType) -> ToDoItem {
        switch type {
        case .todo:
            return todoContent.get(index: index) ?? ToDoItem()
        case .doing:
            return doingContent.get(index: index) ?? ToDoItem()
        case .done:
            return doneContent.get(index: index) ?? ToDoItem()
        }
    }

    func delete(from index: Int, of type: ProjectType) {
        projectDataManager.delete(item: todoContent.get(index: index) ?? ToDoItem(), of: type)
    }
}
