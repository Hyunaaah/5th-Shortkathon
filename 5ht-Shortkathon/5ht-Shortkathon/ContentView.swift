//
//  ContentView.swift
//  5ht-Shortkathon
//
//  Created by 주현아 on 5/24/25.
//


import SwiftUI

struct ContentView: View {
    
init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    } // init
    var body: some View {
            TabView() {
                BookListView()
                    .tabItem{
                        Image(systemName : "house.fill")
                    }
                    .tag(0)
                
                AddBookView(onAdd: { _ in })
                    .tabItem{
                        Image(systemName : "diamond.fill")
                    }
                    .tag(1)
                
                SetAlarmView()
                    .tabItem{
                        Image(systemName : "alarm.fill")
                    }
                    .tag(2)
                
                AccountView()
                    .tabItem{
                        Image(systemName : "chart.line.uptrend.xyaxis")
                    }
                    .tag(3)
                
               
            } // TabView
    }
}

#Preview {
    ContentView()
}
