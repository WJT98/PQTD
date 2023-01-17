//
//  TimerView.swift
//  PQTD
//
//  Created by William Tang on 2023-01-15.
//

import SwiftUI
import UserNotifications

//LinearGradient(gradient: Gradient(colors: [Color.accentColor, Color("TimerColor")])
//startPoint: .topLeading,
//endPoint: .bottomTrailing),

struct TimerView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State var curItemID: String = "1"
    @State var nextItemID: String = "1"
    @State var counter: Int = 0
    @State var timerRunning: Bool = false

    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack{
                    Text(counterToMinutes(currentTimeSeconds:
                                            listViewModel.getItem(itemID: curItemID).remainingTime))
                        .font(.system(size:40))
                
                    Circle()
                    .trim(from: 0, to: 1)
                        .stroke(Color.black.opacity(0.09), style: StrokeStyle(lineWidth: 14, lineCap: .round))
                    .frame(width: 200, height: 200)
                    
                    Circle()
                        .trim(from: 0, to: CGFloat(counter)/CGFloat(listViewModel.getItem(itemID: curItemID).remainingTime))
                        .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 14, lineCap: .round))
                    .frame(width: 200, height: 200)
                    .rotationEffect(.init(degrees: -90))
                }
                Button {
                    self.timerRunning.toggle()
                } label: {
                    Text(timerRunning ? "Pause" : "Start")
                }
                .padding(.horizontal)
                .frame(height: 55)
                .frame(maxWidth: 300)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(10)

                Spacer()
                
                Text("Next Task")
                    .font(.title)
                GroupBox {
                    ListRowView(item: listViewModel.getItem(itemID:curItemID), value: listViewModel.getItem(itemID:curItemID).remainingTime.description)
                }
                
            }
            .onAppear(perform: {
                self.curItemID = listViewModel.getFirstItem().id
               // self.nextItemID = 0
            })
            .onReceive(timer, perform: { value in
                if listViewModel.getItem(itemID:curItemID).isCompleted {
                    timer.upstream.connect().cancel()
                    self.timerRunning = false
                }
                if timerRunning {
                    self.counter += 1
                    updateItemModelTime(itemID: curItemID)
                }
            })
            .navigationTitle(Text("Timer"))
        }
    }
    func updateItemModelTime(itemID: String) {
        listViewModel.decrementItemRemainingTime(
            item:listViewModel.getItem(itemID:curItemID),
            time:1)
        listViewModel.incrementItemElapsedTime(
            item:listViewModel.getItem(itemID:curItemID),
            time:1)
    }
    
    func counterToMinutes(currentTimeSeconds: Int) -> String {
            let seconds = currentTimeSeconds % 60
            let minutes = Int(currentTimeSeconds / 60)
            return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
            .environmentObject(ListViewModel())
    }
}
