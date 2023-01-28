//
//  FloatingStartButton.swift
//  PQTD
//
//  Created by William Tang on 2023-01-18.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    let icon: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink {
                    TimerView()
                } label: {
                    Button(action: action) {
                        Image(systemName: icon)
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                    }
                    .frame(width: 60, height: 60)
                    .background(Color.accentColor)
                    .cornerRadius(30)
                    .shadow(radius: 10)
                    .offset(x: -25, y: 10)
                }
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton(action: {}, icon: "play.circle")
    }
}
