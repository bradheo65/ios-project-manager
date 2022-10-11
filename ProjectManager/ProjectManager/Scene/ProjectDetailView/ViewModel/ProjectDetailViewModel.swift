//
//  ProjectDetailViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/23.
//

import Foundation

final class ProjectDetailViewModel {
    
    // MARK: - Properties
    
    private let projectDataManager = ProjectDataManager()
    
    // MARK: - Functions
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        projectDataManager.update(item: item, from: index, of: type)
    }
}
