//
//  SettingsView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        
        NavigationView {
            Form {
                
                Section(header: Text("Tasks")) {
                    NavigationLink {
                        AddCategoryView()
                    } label: {
                        Label("Categories", systemImage: "folder")
                    }
                }
                
                Section(header: Text("Display")) {
                    Toggle(isOn: .constant(false),
                           label: {Text("Dark mode")})
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
