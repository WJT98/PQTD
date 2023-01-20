//
//  TabView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct BottomTabView: View {
    // Property wrapper needed to view changes
    @StateObject var listViewModel: IPQViewModel = IPQViewModel()
    
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Todo List", systemImage: "note")
                }
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "list.bullet")
                }
        }
    }
}

struct BottomTabViewPreviews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
            .environmentObject(IPQViewModel())
    }
}
