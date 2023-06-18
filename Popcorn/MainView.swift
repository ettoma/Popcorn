//
//  MainView.swift
//  Popcorn
//
//  Created by Ettore Toma on 18/05/2023.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
      }
    
    var body: some View {
        
        NavigationStack {
            TabView {
               HomeView()
                    .tabItem {
                        Label("home", systemImage: "house")
                    }
                WatchlistView()
                     .tabItem {
                         Label("watchlist", systemImage: "popcorn.fill")
                     }
                ProfileView()
                     .tabItem {
                         Label("account", systemImage: "person")
                     }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
