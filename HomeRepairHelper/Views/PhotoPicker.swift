//
//  PhotoPicker.swift
//  HomeRepairHelper
//
//  Created by robevans on 5/20/22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var pickedImage: UIImage
    @Binding var imageURL: [NSURL]

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true // allows cropping
        
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {

        return Coordinator(photoPicker: self)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let photoPicker: PhotoPicker

        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage{
                //we can get the id as well??
                photoPicker.imageURL.append(info[.imageURL] as! NSURL)
                guard let data = image.jpegData(compressionQuality: 0.1), let compressedImage = UIImage(data: data) else {
                    print("error")
                    return
                }
                photoPicker.pickedImage = compressedImage

            } else {
                print("some error")
            }
            picker.dismiss(animated: true)
        }
    }

}
