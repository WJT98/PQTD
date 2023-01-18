//
//  IPQViewModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import Foundation

/*
 CRUD Functions stored in ViewModels
 
 Create
 Read
 Update
 Delete
 
 Implementation of Indexed Priority Queue
 
 */

class IPQViewModel: ObservableObject {
    
    //Use @published instead of @state inside a class
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItemsFromAppStorage()
    }
    
    func getItemsFromAppStorage() {
        // guard let since data is optional (could be empty)
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode( [ItemModel].self, from: data)
        else {
            return
        }
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String, categoryID: String) {
        let newItem = ItemModel(title: title, categoryID: categoryID)
        items.append(newItem)
    }
    
    func updateItemCompletion(item: ItemModel) {
    
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            objectWillChange.send()
            items[index].updateCompletion()
            //items[index] = item.updateCompletion()
        }
    }
    
    func getItem(itemID: String) -> ItemModel {
        if let index = items.firstIndex(where: { $0.id == itemID}) {
            return items[index]
        }
        return ItemModel(title: "Null Item")
    }
    
    func decrementItemRemainingTime(item: ItemModel, time: Int) {
        objectWillChange.send()
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index].decrementRemainingTime(time: time)
        }
    }
    
    func incrementItemElapsedTime(item: ItemModel, time: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index].incrementElapsedTime(time: time)
        }
    }
    
    func getFirstItem() -> ItemModel {
        if items.isEmpty {
            addItem(title: "Item inserted by getfirstitem", categoryID: "null")
        }
        return items[0]
    }
        
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    

}
