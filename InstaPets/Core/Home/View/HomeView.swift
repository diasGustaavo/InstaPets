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
    
    var body: some View {
//        LoginView()
            if authViewModel.userSession == nil {
                LoginView()
            } else if let user = authViewModel.currentUser {
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
                            PersonalProfileView(uid: user.uid)
                        } else if viewModel.selectedTab == .likes {
                            NotificationsView(userUid: user.uid)
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
