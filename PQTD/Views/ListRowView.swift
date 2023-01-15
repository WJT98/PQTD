//
//  ListRowView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import SwiftUI


struct ListRowView: View {
    
    let item: ItemModel
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Spacer()
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "item1", isCompleted: false)
    static var item2 = ItemModel(title: "item2", isCompleted: true)

    static var previews: some View {
        Group {
            ListRowView(item: item1)
            ListRowView(item: item2)
        }
        .previewLayout(.sizeThatFits)
    }
}
