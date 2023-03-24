//
//  NotificationsViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 24/03/23.
//

import Foundation

class NotificationsModelView: ObservableObject {
    @Published var notifications = [Notification]()
    
    init(uid: String) {
        for _ in 1..<50 {
            notifications.append(Notification.example)
        }
    }
}
