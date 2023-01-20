//
//  CategoryViewModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    
    @Published var categories: [CategoryModel] = [] {
        didSet {
            saveCategories()
        }
    }
    
    let categoriesKey: String = "categories_list"

    init() {
        getCategories()
    }
    
    func getCategories() {
        // guard let since data is optional (could be empty)
        guard
            let data = UserDefaults.standard.data(forKey: categoriesKey),
            let savedCategories = try? JSONDecoder().decode([CategoryModel].self, from: data)
        else {
            return
        }
        self.categories = savedCategories
    }
    
    func saveCategories() {
        if let encodedData = try? JSONEncoder().encode(categories) {
            UserDefaults.standard.set(encodedData, forKey: categoriesKey)
        }
    }
    
    func deleteCategory(indexSet: IndexSet) {
        categories.remove(atOffsets: indexSet)
    }
    
    func moveCategory(from: IndexSet, to: Int) {
        categories.move(fromOffsets: from, toOffset: to)
    }
    
    func incrementTotalTasks(categoryID: String, count: Int){
        if let index = categories.firstIndex(where: { $0.id == categoryID}) {
            categories[index].incrementTotalTasks(count: count)
        }
    }
    func incrementCompletedTasks(categoryID: String, count: Int){
        if let index = categories.firstIndex(where: { $0.id == categoryID}) {
            categories[index].incrementCompletedTasks(count: count)
        }
    }
    
    func getTasksStatistics(categoryID:String) -> (Int,Int) {
        if let index = categories.firstIndex(where: { $0.id == categoryID}) {
            return (categories[index].completedTasks, categories[index].totalTasks)
        }
        return (0,0)
    }
    
    
    
    func getCategory(categoryID: String) -> CategoryModel {
        if let index = categories.firstIndex(where: { $0.id == categoryID}) {
            return categories[index]
        }
        return CategoryModel(title: "Null Category")
    }
    
    func addCategory(title: String, categoryColor: Color, icon: String) {
        let newCategory = CategoryModel(title: title,
                                        categoryColor: categoryColor,
                                        icon: icon)
        categories.append(newCategory)
    }
    
    func getFirstCategory() -> CategoryModel {
        if categories.isEmpty {
            addCategory(title: "Default Category", categoryColor: Color.accentColor, icon: "heart.fill")
        }
        return categories[0]
    }

}
