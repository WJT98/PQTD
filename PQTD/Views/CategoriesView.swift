//
//  CategoriesView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-17.
//

import SwiftUI

struct CategoriesView: View {
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    
    @State var textFieldTitle: String = ""
    @State var addCategoryVisible: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categoryViewModel.categories) { item in
                    HStack{
                        Text(item.title)
                        Spacer()
                        Image(systemName: item.id)
                            .foregroundColor(item.categoryColor)
                    }
                }
                .onDelete(perform: categoryViewModel.deleteCategory)
                .onMove(perform: categoryViewModel.moveCategory)
            }
            .listStyle(PlainListStyle())
            .id(UUID())
        }
        .navigationTitle("Categories")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                Button("Add Category") {
                    addCategoryVisible.toggle()
                }
                .sheet(isPresented: $addCategoryVisible) {
                    NavigationView {
                        AddCategoryView()
                            .presentationDetents([.medium, .large])
                    }
                }
        )
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CategoriesView()
        }
        .environmentObject(CategoryViewModel())
    }
}
