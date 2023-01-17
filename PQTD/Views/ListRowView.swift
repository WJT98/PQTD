//
//  ListRowView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import SwiftUI


struct ListRowView: View {
    
    let item: ItemModel
    var value: String
    var unit: String = " Seconds"
    
    @ScaledMetric var size: CGFloat = 1

    
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
            Text(item.title)
            Text(String(item.remainingTime))
            Text(String(item.isCompleted))
            Spacer()
        }
        .font(.title2)
        .padding(.vertical, 8)
//        HStack{
//            GroupBox(
//                label: Label(item.title, systemImage: "heart.fill")
//                    .foregroundColor(.blue)
//            ) {
//                Text(value + unit)
//            }
//            .padding(.horizontal)
//        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "item1", isCompleted: false)
    static var item2 = ItemModel(title: "item2", isCompleted: true)

    static var previews: some View {
        Group {
            ListRowView(item: item1, value: item1.remainingTime.description)
            ListRowView(item: item2, value: item1.remainingTime.description)
        }
        .previewLayout(.sizeThatFits)
    }
}
