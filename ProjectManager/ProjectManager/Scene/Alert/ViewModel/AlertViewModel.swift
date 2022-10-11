//
//  AlertViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation

final class AlertViewModel {
    
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
    
    func move(project: ProjectType, in index: IndexPath, to anotherProject: ProjectType) {
        fetch()
        switch project {
        case .todo:
            projectDataManager.move(item: todoContent.get(index: index.row) ?? ToDoItem(), project: project, to: anotherProject)
        case .doing:
            projectDataManager.move(item: doingContent.get(index: index.row) ?? ToDoItem(), project: project, to: anotherProject)
        case .done:
            projectDataManager.move(item: doneContent.get(index: index.row) ?? ToDoItem(), project: project, to: anotherProject)
        }
        fetch()
    }
}
