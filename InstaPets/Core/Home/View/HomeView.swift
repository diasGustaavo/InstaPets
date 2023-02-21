//
//  ContentView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 16/02/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        if authViewModel.userSession == nil {
            LoginView()
        } else if let user = authViewModel.currentUser {
            ZStack {
                Color(UIColor(Color.theme.backgroundColor))
                    .ignoresSafeArea(.all)

                VStack {
                    Spacer()

                    MainTabBarView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
            .environmentObject(AuthViewModel())
    }
}
