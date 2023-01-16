//
//  NoItemsView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    let SecondaryAccentColor = Color("SecondaryAccentColor")

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("There are no items!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Click the add button to start. Make sure your tasks are short and manageable.")
                    .padding(.bottom, 20)
                NavigationLink (
                    destination: AddTaskView(),
                    label: {
                        Text("Add Something 🥳")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(height: 55)
                            .frame(maxWidth: . infinity)
                            .background(animate ? Color.blue : SecondaryAccentColor)
                            .cornerRadius(10)
                           
                        
                })
                .padding(.horizontal, 30)
                .shadow (
                    color: animate ? Color.blue.opacity(0.7) : SecondaryAccentColor.opacity(0.7),
                    radius: 10,
                    x: 0,
                    y: 0
                )

                

            }
            .frame(maxWidth: 400)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)

    }
    
    func addAnimation() {
        
        guard !animate else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                .easeInOut(duration: 2.0)
                .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NoItemsView()
    }
}
