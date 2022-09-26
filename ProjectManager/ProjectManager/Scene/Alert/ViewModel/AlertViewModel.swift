//
//  AlertViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation
import RealmSwift

final class AlertViewModel {
    
    // MARK: - Singletone

    private let localDataManager = LocalDataManager.shared
    
    // MARK: - Functions

    func searchContent(from index: Int, of type: ProjectType) -> RealmToDoItem {
        switch type {
        case .todo:
            return localDataManager.todoList.get(index: index) ?? RealmToDoItem()
        case .doing:
            return localDataManager.doingList.get(index: index) ?? RealmToDoItem()
        case .done:
            return localDataManager.doneList.get(index: index) ?? RealmToDoItem()
        }
    }
    
    func move(project: ProjectType, in index: IndexPath, to anotherProject: ProjectType) {
        let movingContent = searchContent(from: index.row, of: project)
        
        append(new: movingContent, to: anotherProject)
        delete(from: index.row, of: project)
    }
    
    private func append(new item: RealmToDoItem, to type: ProjectType) {
        localDataManager.create(with: item, with: type)
    }
    
    private func delete(from index: Int, of type: ProjectType) {
        localDataManager.delete(index: index, with: type)
    }
}
