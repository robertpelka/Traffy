//
//  ImageUploader.swift
//  Traffy
//
//  Created by Robert Pelka on 30/11/2021.
//

import Foundation
import UIKit
import Firebase

struct ImageUploader {
    static func uploadImage(image: UIImage, fileName: String, completion: @escaping (String) -> Void) {
        let imageRef = Storage.storage().reference().child("profilePictures/" + fileName + ".jpeg")
        let resizedImage = image.resize(maxSideLength: 128)
        
        guard let compressedImage = resizedImage.jpegData(compressionQuality: 0.1) else {
            print("DEBUG: Error converting UIImage to jpeg.")
            return
        }
        
        imageRef.putData(compressedImage, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Error uploading image: \(error.localizedDescription)")
                return
            }
            imageRef.downloadURL { url, error in
                if let error = error {
                    print("DEBUG: Error getting image url: \(error.localizedDescription)")
                    return
                }
                guard let url = url?.absoluteString else {
                    print("DEBUG: Error converting URL to String.")
                    return
                }
                completion(url)
            }
        }
    }
}

