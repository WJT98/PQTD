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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
