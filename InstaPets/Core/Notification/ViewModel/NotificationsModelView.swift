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
    @Published var notificationsThumbs = [UIImage?]()
    
    private let userService = UserService.shared
    
    init() {
        userService.fetchUserNotifications(completion: { notifications in
            self.notifications = notifications
            self.fetchAllPostsMainImages()
        })
    }
    
    func fetchAllPostsMainImages() {
        let postsUID = notifications.map { $0.postUID }
        let postsAmount = postsUID.count
        notificationsThumbs = [UIImage?](repeating: nil, count: postsUID.count)
        
        for (index, imageFolder) in postsUID.enumerated() {
            print("imageFolder = \(imageFolder)")
            let storageRef = Storage.storage().reference(withPath: imageFolder)
            
            storageRef.listAll { (result, error) in
                if let error = error {
                    print("Error listing files: \(error.localizedDescription)")
                    return
                }
                
                // Unwrap the items array
                guard let result = result else { return }
                print("DEBUG: Results = \(result.items)")
                
                // List all items in the folder
                if !result.items.isEmpty {
                    result.items[0].getData(maxSize: 10000 * 10000) { data, e in
                        if let e = e {
                            print("DEBUG: Error downloading image: \(e.localizedDescription)")
                        }
                        else {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                guard let image = image else { return }
                                
                                self.notificationsThumbs[index] = image
                            }
                        }
                    }
                }
            }
        }
    }
}
