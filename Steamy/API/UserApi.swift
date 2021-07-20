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

class UserApi: ObservableObject, UserServiceProtocol {
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    
    func signUp(email: String, password: String, firstName: String, lastName: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
            }
            
            if let authData = result {
                print(authData.user.email)
                let dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "firstName": firstName,
                    "lastName": lastName,
                    "profileImageUrl": "",
                    "status": "Welcome to Steamy"
                ]
                
                Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict) { error, ref in
                    if error == nil {
                        DispatchQueue.main.async {
                            self?.signedIn = true
                        }
                        onSuccess()
                    } else {
                        onError(error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authData, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
            
            print(authData?.user.email)
            
            onSuccess()
        }
                
    }
    
    func signOut(onError: @escaping(_ errorMessage: String) -> Void) {
        try? Auth.auth().signOut()
        self.signedIn = false
        
    }
    
    func getUserDetails(uid: String, onSuccess: @escaping(UserCompletion)) {
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let user = User.transformUser(dict: dict) {
                    onSuccess(user)
                }
            }
        }
    }
    
    func saveUserProfile(dict: Dictionary<String, Any>,  onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Ref().databaseSpecificUser(uid: Api.User.currentUserId).updateChildValues(dict) { (error, dataRef) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
}

typealias UserCompletion = (User) -> Void
