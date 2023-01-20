//
//  TagsViewModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-19.
//

import Foundation


class TagsViewModel: ObservableObject {
    
    enum TagStatus: Int, Codable {
        case unselected = 0
        case selected = 1
        case ignore = 2
    }

    //Use @published instead of @state inside a class
    
//    @Published var tags: [String:TagStatus] = [String:TagStatus]() {
    @Published var tags: [String:TagStatus] = ["A":TagStatus.unselected, "B": TagStatus.selected, "C": TagStatus.ignore] {
        didSet {
            saveTags()
        }
    }


    
    let tagsKey: String = "tags"
    
    init() {
        getTagsFromAppStorage()
    }
    
    func getTagsFromAppStorage() {
        guard
            let data = UserDefaults.standard.data(forKey: tagsKey),
            let savedTags = try? JSONDecoder().decode([String:TagStatus].self, from: data)
        else {
            return
        }
        self.tags = savedTags
    }
    
    func deleteTag(key:String) {
        if tags.keys.contains(key){
            self.tags.removeValue(forKey: key)
        }
    }
    
    func addTag(key: String) {
        self.tags[key] = .unselected
    }
    
    func updateTag(key: String, tagStatus: TagStatus) {
        self.tags[key] = tagStatus
    }
    
    func getTagStatus(key: String) -> TagStatus {
        if let val = tags[key]{
            return val
        }
        return .unselected
    }
    
    func toggleTagStatus(key: String){
        let curStatus = getTagStatus(key: key)
        if curStatus == TagStatus.unselected{
            updateTag(key: key, tagStatus: TagStatus.selected)
        } else if curStatus == .selected{
            updateTag(key: key, tagStatus: TagStatus.ignore)
        } else {
            updateTag(key: key, tagStatus: .unselected)
        }
    }
    
    func renameTag(key: String, newKey: String){
        let curStatus = getTagStatus(key:key)
        deleteTag(key: key)
        addTag(key: newKey)
    }
    
    func getIgnoreTags() -> Set<String> {
        return Set(tags.filter({$0.value == TagStatus.ignore}).keys)
    }
    
    func getSelectedTags() -> Set<String> {
        return Set(tags.filter({$0.value == TagStatus.selected}).keys)
    }
    
    func getKeys() -> [String] {
        return Array(tags.keys)
    }
    
    func saveTags() {
        if let encodedData = try? JSONEncoder().encode(tags) {
            UserDefaults.standard.set(encodedData, forKey: tagsKey)
        }
    }

    
}
