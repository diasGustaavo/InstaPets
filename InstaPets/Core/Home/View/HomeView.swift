//
//  ContentView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 16/02/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
            
            VStack {
                Spacer()
                
                MainTabBarView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
