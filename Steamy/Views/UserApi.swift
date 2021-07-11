//
//  UserApi.swift
//  Steamy
//
//  Created by Chee Jun Wong on 6/24/21.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import ProgressHUD

protocol UserServiceProtocol {
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void)
}

class UserApi: UserServiceProtocol {
    
    func signUp(email: String, password: String, firstName: String, lastName: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
            }
            
            if let authData = result {
                print(authData.user.email)
                let dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "first_name": firstName,
                    "last_name": lastName,
                    "profileImageUrl": "",
                ]
                
                Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict) { error, ref in
                    if error == nil {
                        onSuccess()
                    } else {
                        onError(error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            print(authData?.user.email)
            onSuccess()
        }
                
            
        
    }
}
