//
//  ListRowView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-14.
//

import SwiftUI


struct ListRowView: View {
    
    let item: ItemModel
    let category: CategoryModel
    var priority: Int
    var remainingTime: Int
    var title: String
    var dueDate: Date? = nil
    var groupBoxColor: Color
    var categoryTitle: String

    
    @ScaledMetric var size: CGFloat = 1
    
    init (item: ItemModel, category: CategoryModel) {
        self.item = item
        self.category = category
        self.priority = item.priority
        self.remainingTime = item.remainingTime
        self.title = item.title
        self.dueDate = item.dueDate
        self.groupBoxColor = category.categoryColor
        self.categoryTitle = category.title
    }
    
    var body: some View {
        NavigationLink (destination: EditTaskView()) {
            VStack {
                HStack {
                    Image(systemName: category.icon)
                        .foregroundColor(groupBoxColor)
                        .font(.system(size: 20 * size))
                        .padding(.bottom,5)
                    Text(categoryTitle)
                        .foregroundColor(groupBoxColor)
                        .font(.system(size: 20 * size))
                        .padding(.bottom, 5)
                    
                    Spacer()
                    
                    if item.isCompleted {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    } else {
                        Text(item.getFormattedTime(totalSeconds: item.remainingTime))
                            .foregroundColor(Color.black.opacity(0.7))
                            .font(.system(size: 15 * size))
                            .fontWeight(.light)
                    }
                    
                }
                .padding(.leading, 5)
                HStack{
                    Text(title).font(.system(size: 26 * size, weight: .bold, design: .rounded))
                    Text(String(priority)).font(.system(size: 20 * size, weight: .bold, design: .rounded))
                    Image(systemName: "heart.fill") .foregroundColor(Color.red)
                    Spacer()
                }
                .padding(.horizontal, 5)
                .frame(minHeight: 1, maxHeight: 30)
                .foregroundColor(Color.black)
            }
        }
    }
}


struct ListRowView_Previews: PreviewProvider {
    
    static var item1 = ItemModel(title: "item1", isCompleted: false)
    static var item2 = ItemModel(title: "item2", isCompleted: true)
    static var category1 = CategoryModel()

    
    static var previews: some View {
        Group {
            ListRowView(item: item1, category:category1)
            ListRowView(item: item2, category:category1)
        }
        .previewLayout(.sizeThatFits)
    }
}
