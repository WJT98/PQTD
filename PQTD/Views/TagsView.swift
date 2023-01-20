//
//  TagsView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-19.
//

import SwiftUI


struct TagsView: View {
    @EnvironmentObject var tagsViewModel: TagsViewModel
    @State private var showAlert: Bool = false
    @State private var tagTitle: String = ""
    @State private var alertTitle: String = ""

    var body: some View {
        HStack{
            ForEach(tagsViewModel.getKeys(), id: \.self){ tag in
                Button(action: {}) {
                    Text(tag)
                        .strikethrough(tagsViewModel.getTagStatus(key: tag) == .ignore ? true : false)
                        .frame(minWidth: 30)
                }
                .highPriorityGesture(
                    TapGesture()
                        .onEnded { _ in
                            tagsViewModel.toggleTagStatus(key: tag)
                        }
                    )
                .contextMenu {
                        Button("Rename Tag") {
                            self.showAlert = true
                        }
                        Button(role: .destructive){
                            tagsViewModel.deleteTag(key: tag)
                        } label: {
                            Label("Delete Tag", systemImage: "trash")
                        }
                    }
                .alert("Rename Tag", isPresented: $showAlert, actions: {
                    TextField("New Tag Name", text: $tagTitle)
                    Button("Cancel", role: .cancel, action: {})
                    Button("OK", action: {renameTag(key:tag, newKey: tagTitle)})
                }, message: {
                    Text(tag + " will be updated in ")
                })
                .buttonStyle(.borderedProminent)
                .tint(tagsViewModel.getTagStatus(key: tag) == .unselected ? Color.gray : (tagsViewModel.getTagStatus(key: tag) == .selected ? Color.accentColor : Color("SecondaryAccentColor")))
                .controlSize(.regular)
                .cornerRadius(20)

            }
        }

    }
    
    func renameTag(key: String, newKey: String){
        if tagTitle.count > 1 {
            tagsViewModel.renameTag(key: key, newKey: tagTitle)
        }
    }
    
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView()
            .environmentObject(TagsViewModel())
    }
}
