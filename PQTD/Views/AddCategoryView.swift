//
//  AddCategoryView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct AddCategoryView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    
    @State var textFieldTitle: String = ""
    @State var showAlert: Bool = false
    @State var alertTitle: String = "book.fill"
    @State var categoryColor: Color = Color.accentColor
    @State var icon: String = ""
    let listIcons = ["book.fill", "heart.fill", "dumbbell.fill", "note.text", "cart.fill"]
    
    var body: some View {
        Form {
            Section(header: Text("Category")) {
                TextField("Title", text: $textFieldTitle)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                
                ColorPicker("Choose your category color", selection: $categoryColor)
                Picker("Select an icon", selection: $icon) {
                    ForEach(listIcons, id: \.self) { iconName in
                        Image(systemName: iconName).tag(iconName)
                    }
                    
                }
                .padding(.vertical)
                .frame(maxHeight: 100)
                .pickerStyle(.wheel)
            }
        }
        .navigationBarTitle(Text("New Category"))
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert, content: getAlert)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Add") {
                    saveButtonPressed()
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
    }
    
    func saveButtonPressed(){
        if textIsAppropriate() {
            categoryViewModel.addCategory(title: textFieldTitle, categoryColor: categoryColor, icon: icon)
            dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldTitle.count < 1 {
            alertTitle = "Your new category must be at least 1 character long."
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
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
