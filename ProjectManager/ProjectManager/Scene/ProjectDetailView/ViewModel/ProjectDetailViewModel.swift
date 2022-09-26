//
//  ProjectDetailViewModel.swift
//  ProjectManager
//
//  Created by brad, bard on 2022/09/23.
//

import Foundation
import RealmSwift

class ProjectDetailViewModel {
    
    let localDataManager = LocalDataManager.shared
    
    func append(new item: RealmToDoItem, to type: ProjectType) {
        localDataManager.create(with: item, with: type)
    }
    
    func update(item: RealmToDoItem, from index: Int, of type: ProjectType) {
        localDataManager.update(item: item, from: index, of: type)
    }
}
