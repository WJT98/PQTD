//
//  ItemModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    var title: String
    var isCompleted: Bool
    var remainingTime: Double
    //var category: CategoryModel
//    let priority: Int
//    let dueDate: Date
    // let
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.remainingTime = 300
    }
    
    mutating func updateCompletion() -> Void {
        self.isCompleted = !self.isCompleted
    }
    
    
    
}
