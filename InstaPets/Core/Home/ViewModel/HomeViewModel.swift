//
//  HomeViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 18/02/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var selectedTab: TabBarButtonType = .home
    @Published var formerSelectedTab: TabBarButtonType = .home
}
