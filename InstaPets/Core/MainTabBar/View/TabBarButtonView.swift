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
    case profile = "person.crop.circle"
    
    func getSelectedButton() -> String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "magnifyingglass.circle.fill"
        case .post:
            return "plus.app.fill"
        case .profile:
            return "person.crop.circle.fill"
        }
    }
}

struct TabBarButtonView: View {
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
            viewModel.selectedTab = type
        } label: {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.theme.primaryTextColor)
        }
        .frame(height: 32)
    }
}

struct TabBarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButtonView(type: .profile)
            .environmentObject(HomeViewModel())
    }
}
