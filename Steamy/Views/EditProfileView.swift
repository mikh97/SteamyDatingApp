//
//  EditProfileView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/5/21.
//

import SwiftUI
import ProgressHUD
import Combine

struct EditProfileView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var age = ""
    @State var selectedGender: String = ""
//    @State var location: String=""
    @State var info_saved = false
//    @State var selectedLocation = ""
    
    @Binding var showSheetView: Bool
    
    @State var gender = ["Male", "Female"]
    
    func updateUserProfile() {
        let dict: Dictionary<String, Any> = [
            "firstName": firstName,
            "lastName": lastName,
            "age": age,
            "gender": selectedGender
        ]
        
        Api.User.saveUserProfile(dict: dict) {
            print("profile update success")
            ProgressHUD.dismiss()
            self.showSheetView = false
        } onError: { errorMessage in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section(header: Text("First Name")) {
                    TextField("First Name", text: $firstName)
                }
                
                Section(header: Text("Last Name")) {
                    TextField("Last Name", text: $lastName)
                }
                
                Section(header: Text("Age")) {
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                        .onReceive(Just(age)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.age = filtered
                            }
                        }
                    
                }
                
                Section(header: Text("Gender")) {
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(gender, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
            }
            .padding(.top, 10)
            
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                print("dismiss sheet view - cancel")
                self.showSheetView = false
                
            }, label: {
                Text("Cancel")
                
            }), trailing: Button(action: {
                // save data to firebase
                ProgressHUD.show()
                updateUserProfile()
                print("dismiss sheet view - done")
                
            }) {
                Text("Done").bold()
            })
            .onAppear {
                Api.User.getUserDetails(uid: Api.User.currentUserId) { (user) in
                    firstName = user.firstName
                    lastName = user.lastName
                    age = user.age ?? ""
                    selectedGender = user.gender ?? ""
                }
            }
            
        }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(showSheetView: .constant(true))
    }
}
