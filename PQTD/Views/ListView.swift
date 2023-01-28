//
//  ListView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-27.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: IPQViewModel
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @State private var showTags: Bool = false

    var body: some View {
        NavigationStack{
            ZStack {
                if listViewModel.items.isEmpty {
                    NoItemsView()
                        .transition(AnyTransition.opacity.animation(.easeIn))
                } else {
                    VStack{
                        List {
                            ForEach(listViewModel.items) { item in
                                ListRowView(item: item, category: categoryViewModel.getCategory(categoryID: item.categoryID))
                                //                            .onTapGesture {
                                //                                withAnimation(.linear) {
                                //                                    listViewModel.updateItem(item: item)
                                //                                }
                                //                            }
                            }
                            .onDelete(perform: listViewModel.deleteItem)
                            .onMove(perform: listViewModel.moveItem)
                        }
                        .id(UUID())
                        .listStyle(PlainListStyle())
                        
                        Spacer()
                        DisclosureGroup(
                            isExpanded: $showTags,
                            content: {
                                TagsView()
                            }, label: {
                                Label("Tags", systemImage: "note.text")
                                    .onTapGesture {
                                        withAnimation {showTags.toggle()}
                                    }
                                
                            })
                        .padding(.horizontal)
                    }
                }
                NavigationLink {
                    TimerView()
                } label: {
                    FloatingButton(action: {}, icon: "play.fill")
                }
                .offset(y:-50)
            }
            .navigationTitle("Todo List")
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    NavigationLink("Add", destination: AddTaskView())
                )
        }
    }

}
    


struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(IPQViewModel())
            .environmentObject(CategoryViewModel())
    }
}
