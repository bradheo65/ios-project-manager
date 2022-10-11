//
//  FakeService.swift
//  ProjectManager
//
//  Created by brad on 2022/10/11.
//

import Foundation

final class FakeService {
    
    // MARK: - Functions
 
    func loadData() -> ItemListCategory {
        guard let data: ItemListCategory? = JSONDecoder.decodedJson(jsonName: Design.jsonName),
              let mockItem = data else { return ItemListCategory() }
        return mockItem
    }
    
    private enum Design {
        static let jsonName = "FakeData"
    }
}
