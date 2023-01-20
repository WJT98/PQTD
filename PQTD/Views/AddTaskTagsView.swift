//
//  AddTaskTagsView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-19.
//

import SwiftUI
import WrappingHStack

struct AddTaskTagsView: View {
    @EnvironmentObject var tagsViewModel: TagsViewModel

    var body: some View {
        WrappingHStack(tagsViewModel.getKeys(), id: \.self){ tag in
            Button(action: {toggleTagInclusion(tag:tag)}) {
                Text(tag)
                    .frame(minWidth: 20)
            }
            .buttonStyle(.borderedProminent)
            .tint(tagsViewModel.getNewTaskTags().contains(tag) ? Color.accentColor : Color.gray)
            .controlSize(.regular)
            .padding(.vertical, 5)
            .cornerRadius(10)
        }
    }
    
    func toggleTagInclusion(tag: String){
        if tagsViewModel.getNewTaskTags().contains(tag){
            tagsViewModel.deleteTagFromNewTask(tag: tag)
        } else {
            tagsViewModel.insertTagToNewTask(tag: tag)
        }
    }
}

struct AddTaskTagsView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskTagsView()
            .environmentObject(TagsViewModel())
    }
}
