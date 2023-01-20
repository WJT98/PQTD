//
//  TimePickerView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-19.
//

import SwiftUI

struct TimePickerView: View {
    @State var hours: Int = 0
    @State var minutes: Int = 0

    var body: some View {
                HStack {
                    Picker("", selection: $hours){
                        ForEach(0..<4, id: \.self) { i in
                            Text("\(i) hrs").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    Picker("", selection: $minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i) m").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
                    Picker("", selection: $minutes){
                        ForEach(0..<60, id: \.self) { i in
                            Text("\(i) s").tag(i)
                        }
                    }.pickerStyle(WheelPickerStyle())
        }.padding(.horizontal)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView()
    }
}
