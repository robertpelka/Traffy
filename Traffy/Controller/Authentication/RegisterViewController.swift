//
//  RegisterViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift
import PhotosUI

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var plusButtonImage: UIImageView!
    @IBOutlet weak var plusButtonLabel: UILabel!
    
    @IBOutlet weak var emailTextfieldView: UIView!
    @IBOutlet weak var passwordTextfieldView: UIView!
    @IBOutlet weak var usernameTextfieldView: UIView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    var profileImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    func prepareView() {
        plusButtonImage.layer.cornerRadius = plusButtonImage.frame.width / 2
        emailTextfieldView.layer.cornerRadius = 10
        passwordTextfieldView.layer.cornerRadius = 10
        usernameTextfieldView.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 15
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let image = profileImage else {
            showAlert(withMessage: "Proszę dodać zdjęcie profilowe.")
            return
        }
        guard let email = emailTextfield.text, email != "" else {
            showAlert(withMessage: "Proszę uzupełnić adres e-mail.")
            return
        }
        guard let password = passwordTextfield.text, password != "" else {
            showAlert(withMessage: "Proszę uzupełnić hasło.")
            return
        }
        guard let username = usernameTextfield.text, username != "" else {
            showAlert(withMessage: "Proszę uzupełnić nick.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                switch AuthErrorCode(rawValue: error._code) {
                case .invalidEmail:
                    self.showAlert(withMessage: "Nieprawidłowy adres e-mail.")
                case .emailAlreadyInUse:
                    self.showAlert(withMessage: "Podany adres e-mail jest już zajęty.")
                case .weakPassword:
                    self.showAlert(withMessage: "Hasło nie może być krótsze niż 6 znaków.")
                default:
                    self.showAlert(withMessage: "Wystąpił nieznany błąd.")
                }
                return
            }
            
            guard let firebaseUser = authResult?.user else { return }
            
            ImageUploader.uploadImage(image: image, fileName: firebaseUser.uid) { imageURL in
                let user = User(id: firebaseUser.uid, profileImageURL: imageURL, username: username)
                
                do {
                    try K.Collections.users.document(firebaseUser.uid).setData(from: user)
                }
                catch let error {
                    print("DEBUG: Error uploading user data: \(error.localizedDescription)")
                }
            }
            
            let tabBarView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarView") as! UITabBarController
            self.present(tabBarView, animated: true, completion: nil)
        }
    }
    
}

//MARK: - PHPickerViewControllerDelegate

extension RegisterViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if let result = results.first {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let error = error {
                        print("DEBUG: Error loading a photo: \(error.localizedDescription)")
                    }
                    else {
                        self.profileImage = image as? UIImage
                        if let image = self.profileImage {
                            DispatchQueue.main.async {
                                self.plusButtonImage.image = image
                                self.plusButtonLabel.text = "Zmień zdjęcie profilowe"
                            }
                        }
                    }
                }
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
}
