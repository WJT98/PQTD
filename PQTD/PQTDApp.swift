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
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
            .environmentObject(listViewModel) // all views have access to environment objects
        }
    }
}
