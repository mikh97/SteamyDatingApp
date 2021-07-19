//
//  EditProfileView.swift
//  Steamy
//
//  Created by Neeval Kumar on 7/5/21.
//

import SwiftUI

struct EditProfileView: View {
    
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var age: String=""
    @State var selectedGender = ""
//    @State var location: String=""
    @State var info_saved = false
//    @State var selectedLocation = ""
    
    @Binding var showSheetView: Bool
    
    @State var gender = ["Male", "Female"]
    
    func getDetails() {
        Api.User.getProfileDetails()
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
                }
                
                Picker("Gender", selection: $selectedGender) {
                    ForEach(gender, id: \.self) {
                        Text($0)
                    }
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
                Api.User.updateProfileDetails()
                print("dismiss sheet view - done")
                self.showSheetView = false
                
            }) {
                Text("Done").bold()
            })
        }
        
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(showSheetView: .constant(true))
    }
}
