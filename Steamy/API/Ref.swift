//
//  Ref.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/17/21.
//

import Foundation
import Firebase
import FirebaseStorage

let REF_USER = "users"
let REF_GALLERY = "gallery"
let REF_ACTION = "action"
let REF_MESSAGE_PREVIEW = "messagePreview"
let REF_MESSAGE = "messages"

let URL_STORAGE_ROOT = "gs://steamydatingapp.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"

let STORAGE_GALLERY = "gallery"

class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()

    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }

    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }

    var databaseGallery: DatabaseReference {
        return databaseRoot.child(REF_GALLERY)
    }
    
    func databaseSpecificGallery(uid: String) -> DatabaseReference {
        return databaseGallery.child(uid)
    }
    
    var databaseAction: DatabaseReference {
        return databaseRoot.child(REF_ACTION)
    }
    
    func databaseActionForUser(uid: String) -> DatabaseReference {
        return databaseAction.child(uid)
    }
    
    var databaseMessage: DatabaseReference {
        return databaseRoot.child(REF_MESSAGE)
    }
    
    func databaseMessageSendTo(from: String, to: String) -> DatabaseReference {
        return databaseMessage.child(from).child(to)
    }
    
    var databaseMessagePreview: DatabaseReference {
        return databaseRoot.child(REF_MESSAGE_PREVIEW)
    }
    
    func databaseMessagePreviewInfo(from: String, to: String) -> DatabaseReference {
        return databaseMessagePreview.child(from).child(to)
    }
    
    func databaseMessagePreviewForUser(uid: String) -> DatabaseReference {
        return databaseMessagePreview.child(uid)
    }
    
    
    // Storage Ref

    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)

    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }

    func storageSpecificProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
    }
    
    var storageGallery: StorageReference {
        return storageRoot.child(STORAGE_GALLERY)
    }

    func storageSpecificGallery(uid: String, timestamp: String) -> StorageReference {
        return storageGallery.child(uid).child(timestamp)
    }
    

}
