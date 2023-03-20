//
//  feedPostModelView.swift
//  InstaPets
//
//  Created by Gustavo Dias on 20/03/23.
//

import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage
import UIKit

class feedPostModelView: ObservableObject{
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    @Published var post: Post?
    @Published var postImages: [UIImage]?
    
    init(post: Post) {
        self.post = post
        fetchPostImages { postImages in
            self.postImages = postImages
        }
    }
    
    func fetchPostImages(completion: @escaping ([UIImage]) -> Void) {
        if let postUID = post?.id {
            let storageRef = storage.reference(withPath: postUID)
            
            // List all items in the folder
            storageRef.listAll { (result, error) in
                if let error = error {
                    print("Error listing files: \(error.localizedDescription)")
                    return
                }
                
                // Unwrap the items array
                guard let result = result else { return }
                
                var imageArray = [UIImage]()
                var itemsCount = 0
                for img in result.items {
                    img.getData(maxSize: 10000 * 10000) { data, e in
                        if let e = e {
                            print("DEBUG: Error downloading image: \(e.localizedDescription)")
                        }
                        else {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                if let image = image {
                                    imageArray.append(image)
                                }
                            }
                        }
                        
                        itemsCount += 1
                        if itemsCount >= result.items.count {
                            completion(imageArray)
                        }
                    }
                }
            }
        }
    }
}
