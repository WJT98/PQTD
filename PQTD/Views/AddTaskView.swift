//
//  AddView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import SwiftUI
import Combine

struct AddTaskView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var listViewModel: IPQViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @EnvironmentObject var tagsViewModel: TagsViewModel

    
    @State var textFieldTitle: String = ""
    @State var textFieldPriority: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var textFieldTag: String = ""
    @State private var category: CategoryModel = .emptySelection
    
    
    var body: some View {
        Form {
            Section(header: Text("Task")) {
                TextField("Task Name", text: $textFieldTitle)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                TextField("Priority", text: $textFieldPriority)
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .onReceive(Just(textFieldPriority)) { newValue in
                        print(textFieldTitle)
                        let filtered = newValue.filter { Set("0123456789").contains($0) }
                        if filtered != newValue {
                            self.textFieldPriority = filtered
                        }
                    }
                
                Picker("", selection: $category) {
                    ForEach(categoryViewModel.categories, id: \.self) { category in
                        HStack{
                            Image(systemName: category.icon)
                            Text(category.title)
                                .tag(category as CategoryModel?)
                        }
                        .foregroundColor(category.categoryColor)
                    }
                }
                .padding(.horizontal)
                .frame(maxHeight: 100)
                .pickerStyle(WheelPickerStyle())
                
                HStack {
                    Picker("", selection: $hours){
                        ForEach(0..<4, id: \.self) { i in
                            Text("\(i) h").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    Picker("", selection: $minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i) min").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    Picker("", selection: $seconds){
                        ForEach([0,2,10, 30, 45], id: \.self) { i in
                            Text("\(i) sec").tag(i)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .padding(.horizontal)
                .frame(maxHeight: 150)
            }
            Section(header: Text("Tags")){
                AddTaskTagsView()
                    .padding(.vertical, 10)
                TextField("Add New Tag...", text: $textFieldTag)
                    .disableAutocorrection(true)
                    .onSubmit {
                        if textFieldTag.count > 1{
                            tagsViewModel.addTag(key: textFieldTag)
                            textFieldTag = ""
                        }
                    }
            }
            
        }
        .navigationBarTitle(Text("New Task"))
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
        .onAppear(perform: {
            self.category = categoryViewModel.getFirstCategory()
        })
    }
    
    func saveButtonPressed(){
        if textFieldPriority == ""{
            textFieldPriority = "1"
        }
        if textIsAppropriate() {
            let totalSeconds: Int = seconds + 60*minutes + 3600*hours
            listViewModel.addItem(title: textFieldTitle, categoryID: category.id, priority: Int(textFieldPriority)!, remainingTime: totalSeconds, tags: tagsViewModel.getNewTaskTags())
            tagsViewModel.clearNewTaskTags()
            categoryViewModel.incrementTotalTasks(categoryID: category.id, count: 1)
            dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldTitle.count < 1 {
            alertTitle = "Your new todo item must be at least 1 character long"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
}


struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddTaskView()
        }
        .environmentObject(IPQViewModel())
        .environmentObject(CategoryViewModel())
        .environmentObject(TagsViewModel())
    }
}
