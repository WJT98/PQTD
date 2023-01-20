//
//  PQTDApp.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import SwiftUI

/*
 MVVM Architecture
 
 Model - data point
 View - UI
 Viewmodel - manages Models for View
 */


@main
struct PQTDApp: App {
    
    // Property wrapper needed to view changes
    // Initialize environment object here
    @StateObject var listViewModel: IPQViewModel = IPQViewModel()
    @StateObject var categoryViewModel: CategoryViewModel = CategoryViewModel()
    @StateObject var tagsViewModel: TagsViewModel = TagsViewModel()

    
    var body: some Scene {
        WindowGroup {
                BottomTabView()
                .environmentObject(listViewModel) // all views have access to environment objects
                .environmentObject(categoryViewModel)
                .environmentObject(tagsViewModel)
        }
    }
}
