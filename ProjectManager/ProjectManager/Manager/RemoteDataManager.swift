//
//  RemoteDataManager.swift
//  ProjectManager
//
//  Created by brad on 2022/10/11.
//

import Foundation
import FirebaseFirestore

final class RemoteDataManager {
    let firestoreDB = Firestore.firestore()
}

extension RemoteDataManager {
    
    func create(new item: ToDoItem, to type: ProjectType) {
        
        switch type {
        case .todo:
            let todoCollection = firestoreDB.collection("todoList").document(item.uuid.description)

            todoCollection.setData([
                "title" : item.title,
                "todoDescription" : item.todoDescription,
                "time" : item.timeLimit
            ])
        case .doing:
            let doingCollection = firestoreDB.collection("doingList").document(item.uuid.description)
            
            doingCollection.setData([
                "title" : item.title,
                "todoDescription" : item.todoDescription,
                "time" : item.timeLimit
            ])
        case .done:
            let doneCollection = firestoreDB.collection("doneList").document(item.uuid.description)
            
            doneCollection.setData([
                "title" : item.title,
                "todoDescription" : item.todoDescription,
                "time" : item.timeLimit
            ])
        }
    }
    
    func update(item: ToDoItem, from index: Int, of type: ProjectType) {
        switch type {
        case .todo:
            let todoCollection = firestoreDB.collection("todoList")
            
            todoCollection.document(item.uuid.description).updateData([
                "title" : item.title,
                "todoDescription" : item.todoDescription,
                "time" : item.timeLimit
            ])
        case .doing:
            let doingCollection = firestoreDB.collection("doingList")
            
            doingCollection.document(item.uuid.description).updateData([
                "title" : item.title,
                "todoDescription" : item.todoDescription,
                "time" : item.timeLimit
            ])
        case .done:
            let doneCollection = firestoreDB.collection("doneList")
            
            doneCollection.document(item.uuid.description).updateData([
                "title" : item.title,
                "todoDescription" : item.todoDescription,
                "time" : item.timeLimit
            ])
        }
    }

    func delete(item: ToDoItem, of type: ProjectType) {
        switch type {
        case .todo:
            firestoreDB.collection("todoList").document(item.uuid.uuidString).delete()
        case .doing:
            firestoreDB.collection("doingList").document(item.uuid.uuidString).delete()
        case .done:
            firestoreDB.collection("doneList").document(item.uuid.uuidString).delete()
        }
    }
    
    func move(item: ToDoItem, project: ProjectType, to anotherProject: ProjectType) {
        create(new: item, to: anotherProject)
        delete(item: item, of: project)
    }
}
