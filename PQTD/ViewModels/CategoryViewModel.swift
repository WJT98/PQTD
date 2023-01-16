//
//  CategoryViewModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import Foundation

class CategoryViewModel: ObservableObject {
    @Published var categories: [CategoryModel] = [] {
        didSet {
            saveCategories()
        }
    }
    
    let categoriesKey: String = "categorieslist"

    init() {
        getCategories()
    }
    
    func getCategories() {
        // guard let since data is optional (could be empty)
        guard
            let data = UserDefaults.standard.data(forKey: categoriesKey),
            let savedCategories = try? JSONDecoder().decode( [CategoryModel].self, from: data)
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
    
    //let color = UIColor(red: 0.8, green: 0.1, blue: 0.5, alpha: 1)
    // set max categories

}
