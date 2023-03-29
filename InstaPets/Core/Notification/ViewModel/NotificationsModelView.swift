//
//  NotificationsViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 24/03/23.
//

import Foundation

class NotificationsModelView: ObservableObject {
    @Published var notifications = [Notification]()
    var uid: String
    
    init(uid: String) {
        self.uid = uid
        for _ in 1..<50 {
            notifications.append(Notification.example)
        }
    }
}
