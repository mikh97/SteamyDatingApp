//
//  ImagePicker.swift
//  Steamy
//
//  Created by Chee Jun Wong on 7/14/21.
//


import SwiftUI
import ProgressHUD

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    var imageType: String
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                print("hello")
            }
            
            if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                parent.selectedImage = image
                // send the image to firebase
                if parent.imageType == "profile" {
                    StorageService.savePhotoProfile(image: image, uid: Api.User.currentUserId) {
                        //
                    } onError: { errorMessage in
                        ProgressHUD.showError(errorMessage)
                    }
                }
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
