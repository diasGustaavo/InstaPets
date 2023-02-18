//
//  MainTabBar.swift
//  InstaPets
//
//  Created by Gustavo Dias on 18/02/23.
//

import SwiftUI

struct MainTabBar: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            Color(UIColor(Color.theme.backgroundColor))
            
            HStack {
                TabBarButtonView(type: .home)
                
                Spacer()
                
                TabBarButtonView(type: .search)
                
                Spacer()
                
                TabBarButtonView(type: .post)
                
                Spacer()
                
                
                TabBarButtonView(type: .profile)
            }
            .padding()
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
            .environmentObject(HomeViewModel())
    }
}
