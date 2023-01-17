//
//  TabView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct BottomTabView: View {
    // Property wrapper needed to view changes
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
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
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "list.bullet")
                }
        }
        .navigationBarTitle(Text("TSDF"), displayMode: .inline)
    }
}

struct BottomTabViewPreviews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
            .environmentObject(ListViewModel())
    }
}
