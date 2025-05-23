//
//  ContentView.swift
//  5ht-Shortkathon
//
//  Created by 주현아 on 5/24/25.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.purple // 배경색
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white // 선택된 아이콘
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.white // 선택되지 않은 아이콘
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        
    } // init
    var body: some View {
            TabView(selection: $selectedTab) {
                BookListView()
                    .tabItem{
                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                    }
                    .tag(0)
                
                AddBookView(onAdd: { _ in })
                    .tabItem{
                        Image(systemName: selectedTab == 1 ? "plus.app.fill" : "plus.app")
                    }
                    .tag(1)
                
                MainPage()
                    .tabItem{
                        Image(systemName: selectedTab == 2 ? "alarm.fill" : "alarm")
                    }
                    .tag(2)
                
               
            } // TabView
    }
}

#Preview {
    ContentView()
}
