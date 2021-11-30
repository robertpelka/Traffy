//
//  ResetPasswordViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextfieldView: UIView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfieldView.layer.cornerRadius = 10
        resetPasswordButton.layer.cornerRadius = 15
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func resetPasswordButtonPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, email != "" else {
            showAlert(withMessage: "Proszę uzupełnić adres e-mail.")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                switch AuthErrorCode(rawValue: error._code) {
                case .invalidEmail:
                    self.showAlert(withMessage: "Nieprawidłowy adres e-mail.")
                case .userNotFound:
                    self.showAlert(withMessage: "Brak użytkownika o podanym adresie e-mail.")
                default:
                    self.showAlert(withMessage: "Wystąpił nieznany błąd.")
                }
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    

}
