//
//  LoginViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 28/11/2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfieldView: UIView!
    @IBOutlet weak var passwordTextfieldView: UIView!
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    func prepareView() {
        emailTextfieldView.layer.cornerRadius = 10
        passwordTextfieldView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 15
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let email = emailTextfield.text, email != "" else {
            showAlert(withMessage: "Proszę uzupełnić adres e-mail.")
            return
        }
        guard let password = passwordTextfield.text, password != "" else {
            showAlert(withMessage: "Proszę uzupełnić hasło.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                switch AuthErrorCode(rawValue: error._code) {
                case .wrongPassword:
                    self.showAlert(withMessage: "Podane hasło jest nieprawidłowe.")
                case .userNotFound:
                    self.showAlert(withMessage: "Brak konta o podanym adresie e-mail.")
                case .invalidEmail:
                    self.showAlert(withMessage: "Podano niepoprawny adres e-mail.")
                default:
                    self.showAlert(withMessage: "Wystąpił nieznany błąd.")
                }
                return
            }
            
            let tabBarView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarView") as! UITabBarController
            self.present(tabBarView, animated: true, completion: nil)
        }
    }
    
}
