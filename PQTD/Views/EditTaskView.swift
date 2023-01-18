//
//  EditTaskView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-17.
//

import Foundation

import SwiftUI

struct EditTaskView: View {
    
    
//    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var listViewModel: IPQViewModel
    @State var textFieldTitle: String = ""
    @State var textFieldPriority: Int = 0
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    @State private var category = "a"
    
    var body: some View {
        Form {
            Section(header: Text("Task")) {
                TextField("Title", text: $textFieldTitle)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                TextField("Title", value: $textFieldPriority, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .cornerRadius(10)
            }
 
            Section(header: Text("Category")) {
                Picker("", selection: $category) {
                    ForEach(["a", "b", "c"], id: \.self) {
                        Text("\($0)")
                    }
                }
                .padding(.horizontal)
                .pickerStyle(.wheel)
            }
        }
        .navigationBarTitle(Text("Edit Task"))
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showAlert, content: getAlert)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
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
            
//            Button (action: saveButtonPressed, label: {
//                Text("Save".uppercased())
//                    .foregroundColor(.white)
//                    .font(.headline)
//                    .frame(height:55)
//                    .frame(maxWidth: .infinity)
//                    .background(Color.accentColor)
//                    .cornerRadius(10)
//            })
        
    }
    
    func saveButtonPressed(){
        if textIsAppropriate() {
            //listViewModel.addItem(title: textFieldTitle)
            //presentationMode.wrappedValue.dismiss()
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


struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddTaskView()
        }
        .environmentObject(IPQViewModel())
    }
}
