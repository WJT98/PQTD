//
//  TagModel.swift
//  PQTD
//
//  Created by William Tang on 2023-01-19.
//

import Foundation

struct TagModel: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    var tagStatus: TagStatus
    
    init(id: String = UUID().uuidString, title: String, tagStatus: TagStatus = .unselected){
        self.id = id
        self.title = title
        self.tagStatus = tagStatus
    }
    
    func getStatus() -> TagStatus{
        return self.tagStatus
    }
    
    enum TagStatus: Int, Codable {
        case unselected = 0
        case selected = 1
        case ignore = 2
    }

}

