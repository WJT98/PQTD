//
//  CategoryModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import Foundation


struct CategoryModel: Identifiable, Codable {
    let id: String
    var title: String
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    
    init(id: String = UUID().uuidString, title: String,
         red: CGFloat = 0.5, green: CGFloat = 0.5, blue: CGFloat = 0.5) {
        self.id = id
        self.title = title
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    mutating func changeCategoryColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
}
