//
//  ProjectTableViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import Foundation
import RealmSwift

final class ProjectTableViewModel {
    
    // MARK: - Singletone

    private let localDataManager = LocalDataManager.shared
    
    // MARK: - Functions

    func count(of type: ProjectType) -> Int {
        switch type {
        case .todo:
            return localDataManager.todoList.count
        case .doing:
            return localDataManager.doingList.count
        case .done:
            return localDataManager.doneList.count
        }
    }
    
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
    
    func update(item: RealmToDoItem, from index: Int, of type: ProjectType) {
        localDataManager.update(item: item, from: index, of: type)
    }
    
    func delete(from index: Int, of type: ProjectType) {
            localDataManager.delete(index: index, with: type)
    }
}
