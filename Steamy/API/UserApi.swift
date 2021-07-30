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
    @Published var cardPeople: [Person] = []
    @Published var currentMatchedPersonID = ""
    @Published var isNewUser = false
    
    init() {
        isNewUser = Auth.auth().currentUser?.photoURL == nil
        if currentUserId != "" && !isNewUser {
            loadCardPeople()
        }
    }
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : "nil"
    }
    
//    var isNewUser: Bool {
//        return isSignedIn ? (Auth.auth().currentUser?.photoURL) == nil : false
//    }
    
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
                            self?.isNewUser = true
                            self?.cardPeople = []
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
                self?.isNewUser = (Auth.auth().currentUser?.photoURL) == nil
            }
            print(self?.isNewUser.description)
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
    
    func getGallery(uid: String, onSuccess: @escaping(_ dict: Dictionary<String, String>) -> Void, onEmpty: @escaping(_ isEmpty: Bool) -> Void) {
        let ref = Ref().databaseSpecificGallery(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, String> {
                onSuccess(dict)
            } else {
                onEmpty(true)
            }
            
        }
    }
    
    private func getNewMatch(uid: String, onSuccess: @escaping(_ dataArray: [String]) -> Void){
        var tempArray: [String] = []
        Ref().databaseRoot.child("newMatch").child(uid).observeSingleEvent(of: .value) { snapshot in
            for user in snapshot.children.allObjects as! [DataSnapshot] {
                tempArray.append(user.key)
            }
            onSuccess(tempArray)
        }
    }
    
    
    func loadCardPeople() {
        Ref().databaseUsers.observe(.value) { snapshot in
            self.cardPeople = []
            
            self.getNewMatch(uid: Api.User.currentUserId) { matchedUserIDArray in
                
                for user in snapshot.children.allObjects as! [DataSnapshot] {
                    if let dict = user.value as? Dictionary<String, Any> {
                        
                        if let person = Person.transformPerson(dict: dict) {
                            
                            if person.uid != Api.User.currentUserId  && person.profileImageUrl != "" {
                                
                                if !matchedUserIDArray.contains(person.uid) {
                                    
                                    self.cardPeople.append(person)
                                    self.getGallery(uid: person.uid) { galleryDict in
                                        person.setGalleryImages(value: Array(galleryDict.values))
                                        
                                    } onEmpty: { isEmpty in
                                        if isEmpty {
                                            person.setGalleryImages(value: [person.profileImageUrl])
                                        }
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func swipe(person: Person, direction: SwipeDirection, onSuccess: @escaping(PersonCompletion)) {
        cardPeople.removeLast()
        print(cardPeople.count)
        print("people removed")
        
        // networking to backend
        if let like = direction == .like ? true : false {
            
            Ref().databaseActionForUser(uid: Api.User.currentUserId).updateChildValues([person.uid: like]) { (error, ref) in
                if error == nil, like == true {
                    
                    Ref().databaseActionForUser(uid: person.uid).observeSingleEvent(of: .value) { (snapshot) in
                        
                        guard let dict = snapshot.value as? [String: Bool] else { return }
                        
                        if dict.keys.contains(Api.User.currentUserId), dict[Api.User.currentUserId] == true {
                            Ref().databaseRoot.child("newMatch").child(Api.User.currentUserId).updateChildValues([person.uid: true])
                            
                            Ref().databaseRoot.child("newMatch").child(person.uid).updateChildValues([Api.User.currentUserId: true])
                            
                            let channelId = Message.hash(forMembers: [Api.User.currentUserId, person.uid])
                            let date: Double = Date().timeIntervalSince1970
                            let tempDict = [
                                "from" : Api.User.currentUserId,
                                "to": person.uid,
                                "date": date,
                                "read": true,
                                "text": "New Match"
                            ] as [String : Any]
                            let refFromMessagePreview = Database.database().reference().child(REF_MESSAGE_PREVIEW).child(Api.User.currentUserId).child(channelId)
                            refFromMessagePreview.updateChildValues(tempDict)
                            let refToMessagePreview = Database.database().reference().child(REF_MESSAGE_PREVIEW).child(person.uid).child(channelId)
                            refToMessagePreview.updateChildValues(tempDict)
                            
                            onSuccess(person)
                        }
                    }
                }
            }
        }
        
    }
    
    func getUserInfoSingleEvent(uid: String, onSuccess: @escaping(UserCompletion)) {
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                if let user = User.transformUser(dict: dict) {
                    onSuccess(user)
                }
            }
        }
    }
    
}

enum SwipeDirection {
    case like
    case nope
}

typealias UserCompletion = (User) -> Void
typealias PersonCompletion = (Person) -> Void
