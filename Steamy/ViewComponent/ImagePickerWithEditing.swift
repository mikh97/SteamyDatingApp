//
//  ImagePicker.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/21/21.
//


import SwiftUI
import ProgressHUD

struct ImagePickerWithEditing: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var imageType: String
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerWithEditing>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerWithEditing>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePickerWithEditing
        
        init(_ parent: ImagePickerWithEditing) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.selectedImage = image
                // send the image to firebase
                if parent.imageType == "profile" {
                    StorageService.savePhotoProfile(image: image, uid: Api.User.currentUserId) {
                    } onError: { errorMessage in
                        ProgressHUD.showError(errorMessage)
                    }
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
