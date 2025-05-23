//
//  ContentView.swift
//  CheckTech
//
//  Created by 정태주 on 5/24/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HourMinuteClockView()
        }
        .padding()
        VStack {
            AlarmSliderView()
        }
        .padding()
        VStack {
            TimerCircleView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

