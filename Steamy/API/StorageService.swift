//
//  StorageService.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/17/21.
//

import Foundation
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import ProgressHUD

class StorageService {

    static func savePhotoProfile(image: UIImage, uid: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void)  {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else {
            return
        }

        let storageProfileRef = Ref().storageSpecificProfile(uid: uid)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        storageProfileRef.putData(imageData, metadata: metadata, completion: { (storageMetaData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }

            storageProfileRef.downloadURL(completion: { (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.commitChanges(completion: { (error) in
                            if let error = error {
                                ProgressHUD.showError(error.localizedDescription)
                            }
                        })
                    }

                    Ref().databaseSpecificUser(uid: uid).updateChildValues([PROFILE_IMAGE_URL: metaImageUrl], withCompletionBlock: { (error, ref) in
                        if error == nil {

                            onSuccess()
                        } else {
                            onError(error!.localizedDescription)
                        }
                    })
                }
            })

        })


    }
    
    static func saveGalleryPhoto(image: UIImage, uid: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void)  {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return
        }
        
        let timestamp = String(Int(Double(NSDate().timeIntervalSince1970.description)!))
        let storageProfileRef = Ref().storageSpecificGallery(uid: uid, timestamp: timestamp)

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        storageProfileRef.putData(imageData, metadata: metadata, completion: { (storageMetaData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }

            storageProfileRef.downloadURL(completion: { (url, error) in
                if let metaImageUrl = url?.absoluteString {

                    Ref().databaseSpecificGallery(uid: uid).updateChildValues([timestamp: metaImageUrl], withCompletionBlock: { (error, ref) in
                        if error == nil {
                            onSuccess()
                            
                        } else {
                            onError(error!.localizedDescription)
                        }
                    })
                }
            })

        })


    }
    
    static func deletingImageFromStorage(uid: String, url: String) {
        
        let storageRef = Storage.storage().reference(forURL: url)
        let imageName = storageRef.name
        storageRef.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let ref = Ref().databaseSpecificGallery(uid: uid)
                ref.child(imageName).removeValue { error, dataRef in
                    if error != nil {
                        ProgressHUD.showError(error?.localizedDescription)
                        return
                    }
                    
                }
                print("File deleted successfully")
            }
        }
        
    }
}

