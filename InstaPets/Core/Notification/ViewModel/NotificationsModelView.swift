//
//  NotificationsViewModel.swift
//  InstaPets
//
//  Created by Gustavo Dias on 24/03/23.
//

import UIKit
import FirebaseStorage

class NotificationsModelView: ObservableObject {
    @Published var notifications = [Notification]()
    @Published var notificationsThumbs = [UIImage]()
    @Published var areNotificationsThumbsLoaded = false
    
    private let userService = UserService.shared
    
    init() {
        userService.fetchUserNotifications(completion: { notifications in
            print("DEBUG: Notifications received \(notifications)")
            self.notifications = notifications
            self.fetchAllPostsMainImages()
        })
    }
    
    func fetchAllPostsMainImages() {
        let postsUID = notifications.map { $0.postUID }
        let postsAmount = postsUID.count
        
        var imageFolderCounter = 0
        for imageFolder in postsUID {
            let storageRef = Storage.storage().reference(withPath: imageFolder)
            
            // List all items in the folder
            storageRef.listAll { (result, error) in
                if let error = error {
                    print("Error listing files: \(error.localizedDescription)")
                    return
                }
                
                // Unwrap the items array
                guard let result = result else { return }
                
                result.items[0].getData(maxSize: 10000 * 10000) { data, e in
                    if let e = e {
                        print("DEBUG: Error downloading image: \(e.localizedDescription)")
                    }
                    else {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            guard let image = image else { return }
                            
                            self.notificationsThumbs.append(image)
                            if imageFolderCounter >= postsAmount {
                                self.areNotificationsThumbsLoaded = true
                            }
                        }
                    }
                }
            }
        }
    }
}
