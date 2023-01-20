//
//  ItemModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import Foundation

class ItemModel: Identifiable, Codable, Hashable {
    
    //time is stored in seconds
    
    let id: String
    var title: String
    var isCompleted: Bool
    var remainingTime: Int
    var elapsedTime: Int
    var categoryID: String
    let priority: Int
    let dueDate: Date?
    var tags: Set<String>
    
    init(id: String = UUID().uuidString, title: String,
         isCompleted: Bool = false, remainingTime: Int = 300, elapsedTime: Int = 0, categoryID: String = "heart.fill", priority: Int = 1, dueDate: Date? = nil, tags: Set<String> = Set<String>()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.remainingTime = remainingTime
        self.elapsedTime = elapsedTime
        self.categoryID = categoryID
        self.priority = priority
        self.dueDate = dueDate
        self.tags = tags
    }
    
    func updateCompletion() -> Void {
        self.isCompleted = !self.isCompleted
        //return ItemModel(title: "sdf", isCompleted: !self.isCompleted)
    }
    
    func decrementRemainingTime(time: Int) -> Void {
        if time < 0 || remainingTime > 1 {
            self.remainingTime -= time
            self.isCompleted = false
        } else {
            self.remainingTime = 0
            self.isCompleted = true
        }
    }
    
    func incrementElapsedTime(time: Int) -> Void {
        self.elapsedTime += time
    }
    
    func getFormattedTime(totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = (totalSeconds % 3600) % 60
        
        if hours < 1 {
            return String(format: "%02d:%02d", minutes, seconds)
        } else {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
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
