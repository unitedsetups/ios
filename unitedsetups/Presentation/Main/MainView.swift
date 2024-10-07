//
//  MainView.swift
//  unitedsetups
//
//  Created by Paras KCD on 7/10/24.
//

import SwiftUI

struct MainView: View {
    @State var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .TabStyle()
                    .tabItem {
                        Image("Home")
                            .renderingMode(.template)
                            .tint(selectedTab == 0 ? Color.accentColor : Color.white)
                        Text("Home")
                    }
                    .tag(0)
                ExploreView()
                    .TabStyle()
                    .tabItem {
                        Image("Explore")
                            .renderingMode(.template)
                            .tint(selectedTab == 1 ? Color.accentColor : Color.white)
                        Text("Explore")
                    }
                    .tag(1)
                NotificationsView()
                    .TabStyle()
                    .tabItem {
                        Image("Notifications")
                            .renderingMode(.template)
                            .tint(selectedTab == 2 ? Color.accentColor : Color.white)
                        Text("Notifications")
                    }
                    .tag(2)
                UserView()
                    .TabStyle()
                    .tabItem {
                        Image("Person")
                            .renderingMode(.template)
                            .tint(selectedTab == 3 ? Color.accentColor : Color.white)
                        Text("Profile")
                    }
                    .tag(2)
            }
            .NavigationStackStyle()
        }
    }
}
