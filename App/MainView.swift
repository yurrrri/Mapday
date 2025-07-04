//
//  MainView.swift
//  MapDay
//
//  Created by 이유리 on 7/4/25.
//

import SwiftUI

struct MainView: View {
    @StateObject var vm: MapDayViewModel = MapDayViewModel()
    @State var pageNumber: Int = 1
    
    var body: some View {
        TabView(selection: $pageNumber) {
            DiaryView(vm: vm)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("다이어리")
                }
                .tag(0)
            
            HomeView(vm: vm)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("홈")
                }
                .tag(1)
        }
    }
}

#Preview {
    MainView()
}
