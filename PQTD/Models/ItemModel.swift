//
//  ItemModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import Foundation

class ItemModel: Identifiable, Codable, Hashable {

    
    let id: String
    var title: String
    var isCompleted: Bool
    var remainingTime: Int
    var elapsedTime: Int
    var category: CategoryModel
//    let priority: Int
//    let dueDate: Date
    // let
    
    init(id: String = UUID().uuidString, title: String,
         isCompleted: Bool = false, remainingTime: Int = 300, category: CategoryModel = CategoryModel()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.remainingTime = remainingTime
        self.elapsedTime = 0
        self.category = category
    }
    
    func updateCompletion() -> Void {
        self.isCompleted = !self.isCompleted
        //return ItemModel(title: "sdf", isCompleted: !self.isCompleted)
    }
    
    func decrementRemainingTime(time: Int) -> Void {
        self.remainingTime -= time
    }
    
    func incrementElapsedTime(time: Int) -> Void {
        self.elapsedTime += time
    }
    
    
    func addTime(time: Int) -> Void {
        self.remainingTime += time
    }
    
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        return (lhs.title == rhs.title) && (lhs.remainingTime == rhs.remainingTime)
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(title)
        hasher.combine(remainingTime)
        hasher.combine(elapsedTime)
    }
    
}
