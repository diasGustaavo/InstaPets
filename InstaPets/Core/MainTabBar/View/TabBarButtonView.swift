//
//  TabBarButtonView.swift
//  TinderClone
//
//  Created by Gustavo Dias on 23/01/23.
//

import SwiftUI

enum TabBarButtonType: String {
    case home = "house"
    case search = "magnifyingglass"
    case post = "plus.app"
    case likes = "heart"
    case profile = "pawprint"
    
    func getSelectedButton() -> String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "magnifyingglass.circle.fill"
        case .post:
            return "plus.app.fill"
        case .likes:
            return "heart.fill"
        case .profile:
            return "pawprint.fill"
        }
    }
}

struct TabBarButtonView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var viewModel: HomeViewModel
    
    var type: TabBarButtonType
    var imageName: String {
        if viewModel.selectedTab == type {
            return type.getSelectedButton()
        }
        else {
            return type.rawValue
        }
    }
    
    var body: some View {
        Button {
            withAnimation {
                viewModel.formerSelectedTab = viewModel.selectedTab
                print("former: \(viewModel.formerSelectedTab)")
                viewModel.selectedTab = type
                print("current: \(viewModel.selectedTab)")
                
                if viewModel.selectedTab == .profile {
                    authViewModel.signout()
                }
            }
        } label: {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.theme.foregroundColor)
        }
        .frame(height: 28)
    }
}

struct TabBarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButtonView(type: .profile)
            .environmentObject(HomeViewModel())
            .environmentObject(AuthViewModel())
    }
}
