//
//  MainTabBarView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 18/02/23.
//

import SwiftUI

struct MainTabBarView: View {
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
                
                TabBarButtonView(type: .likes)
                
                Spacer()
                
                TabBarButtonView(type: .profile)
            }
            .padding()
            .padding(.horizontal)
            .shadow(radius: 2)
            .mask(Rectangle().padding(.top, -20))
        }
        .frame(height: 40)
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
            .environmentObject(HomeViewModel())
    }
}
