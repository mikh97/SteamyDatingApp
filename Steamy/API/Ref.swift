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

let URL_STORAGE_ROOT = "gs://steamydatingapp.appspot.com"
let STORAGE_PROFILE = "profile"
let PROFILE_IMAGE_URL = "profileImageUrl"

class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()

    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
    }

    func databaseSpecificUser(uid: String) -> DatabaseReference {
        return databaseUsers.child(uid)
    }

    // Storage Ref

    let storageRoot = Storage.storage().reference(forURL: URL_STORAGE_ROOT)

    var storageProfile: StorageReference {
        return storageRoot.child(STORAGE_PROFILE)
    }

    func storageSpecificProfile(uid: String) -> StorageReference {
        return storageProfile.child(uid)
    }

}
