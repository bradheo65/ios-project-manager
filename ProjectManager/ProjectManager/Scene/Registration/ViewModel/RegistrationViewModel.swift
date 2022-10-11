//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

final class RegistrationViewModel {
    
    // MARK: - Properties
    
    private let projectDataManager = ProjectDataManager()
    
    // MARK: - Functions
    
    func append(new item: ToDoItem, to type: ProjectType) {
        projectDataManager.create(new: item, to: type)
    }
}
