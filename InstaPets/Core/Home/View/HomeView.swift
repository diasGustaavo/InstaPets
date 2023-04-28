//
//  HomeView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 16/02/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: HomeViewModel
    @StateObject var postModel = PostModelView()
    @StateObject var feedModel = feedModelView()
    @StateObject var searchModelView = SearchModelView()
    @StateObject var notificationsModelView = NotificationsModelView()
    @StateObject var personalModelView = PersonalProfileViewModel()
    
    var body: some View {
        //        LoginView()
        if !authViewModel.isLoggedIn {
            LoginView()
        } else if authViewModel.currentUser != nil {
            NavigationStack {
                ZStack {
                    Color(UIColor(Color.theme.backgroundColor))
                        .ignoresSafeArea(.all)
                    
                    VStack {
                        if viewModel.selectedTab == .post && postModel.postReady {
                            CreatePostView(viewModel: postModel)
                                .environmentObject(authViewModel)
                                .environmentObject(viewModel)
                        } else if viewModel.selectedTab == .search {
                            SearchView(modelView: searchModelView)
                        } else if viewModel.selectedTab == .home {
                            feedView(viewModel: feedModel)
                        } else if viewModel.selectedTab == .profile {
                            PersonalProfileView(personalProfileViewModel: personalModelView)
                        } else if viewModel.selectedTab == .likes {
                            NotificationsView(modelView: notificationsModelView)
                        } else if viewModel.selectedTab == .post && !postModel.postReady {
                            ZStack {
                                MockedCreatePostView()
                                PickMediaView(viewModel: postModel)
                            }
                        }
                        else {
                            Spacer()
                        }
                        
                        MainTabBarView()
                            .ignoresSafeArea(.keyboard)
                    }
                    .onAppear {
                        personalModelView.start()
                        notificationsModelView.start()
                    }
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
