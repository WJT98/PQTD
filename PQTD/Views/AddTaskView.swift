//
//  AddView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import SwiftUI

struct AddTaskView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    TextField("Type something here...", text: $textFieldText)
                        .padding(.horizontal)
                        .frame(height: 55)
                        .background(.white)
                        .cornerRadius(10)
                }
                Button (action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height:55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }
            .padding(5)
        }
        .navigationTitle("Add an Item")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed(){
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
        

    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 1 {
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
        .environmentObject(ListViewModel())
    }
}
