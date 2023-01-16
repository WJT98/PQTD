//
//  TabView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct BottomTabView: View {
    var body: some View {
        TabView {
            ListView()
                .tabItem {
                    Label("Todo List", systemImage: "note")
                }
            Text("Timer")
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "list.bullet")
                }
        }
    }
}

struct BottomTabViewPreviews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
            .environmentObject(ListViewModel())
    }
}
