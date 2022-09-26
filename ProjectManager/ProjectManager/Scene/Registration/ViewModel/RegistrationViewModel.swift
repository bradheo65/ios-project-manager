//
//  RegistrationViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/22.
//

import RealmSwift

final class RegistrationViewModel {
    
    // MARK: - Singletone
    
    private let localDataManager = LocalDataManager.shared
    
    // MARK: - Functions
    
    func append(new item: RealmToDoItem) {
        localDataManager.create(with: item, with: .todo)
    }
}
