//
//  CountdownCard.swift
//  Fourneau
//
//  Created by Ryan Henderson on 1/20/23.
//

import SwiftUI

struct CountdownCard: View {
    let length: Int
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining: Int = 1
    
    func timeString(time: Int) -> String {
        let hours   = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    var body: some View {
        TimeCard(text: "Next Action:", time: "\(timeString(time:timeRemaining))", color: .darkOrange)
            .onAppear {
                timeRemaining = length * 60
            }
            .onReceive(timer, perform: {_ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer.upstream.connect().cancel()
                }
            })
    }
}

struct CountdownCard_Previews: PreviewProvider {
    static var previews: some View {
        CountdownCard(length: 4)
    }
}
