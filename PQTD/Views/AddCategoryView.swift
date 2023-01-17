//
//  AddCategoryView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct AddCategoryView: View {
    
    @EnvironmentObject var categoryViewModel: CategoryViewModel

    
    var body: some View {
        NavigationView {
            Text("Categories")
        }
        .navigationTitle("Categories")

    }
}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddCategoryView()
        }
        .environmentObject(CategoryViewModel())
    }
}
