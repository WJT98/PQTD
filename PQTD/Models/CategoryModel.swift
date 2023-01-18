//
//  CategoryModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import Foundation
import SwiftUI


struct CategoryModel: Identifiable, Codable, Hashable {
    let id: String
    var title: String
    var categoryColor: Color
    var totalTasks: Int
    var completedTasks: Int
    var icon: String
    
    init(id: String = UUID().uuidString, title: String = "Default Category", categoryColor: Color = Color.accentColor, icon: String = "heart.fill") {
        self.id = id
        self.title = title
        self.categoryColor = categoryColor
        self.totalTasks = 0
        self.completedTasks = 0
        self.icon = icon
    }
    
    mutating func changeCategoryColor(newColor: Color) {
        self.categoryColor = newColor
    }
    
    mutating func incrementTotalTasks(count: Int){
        self.totalTasks += count
    }
    mutating func incrementCompletedTasks(count: Int){
        self.completedTasks += count
    }
    
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return (lhs.title == rhs.title) &&
                (lhs.categoryColor == rhs.categoryColor) &&
                (lhs.id == rhs.id)
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(title)
        hasher.combine(categoryColor)
        hasher.combine(totalTasks)
        hasher.combine(completedTasks)
        hasher.combine(icon)
    }
    
}

extension CategoryModel {
    static let emptySelection = CategoryModel()
}
