//
//  RegisterViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextfieldView: UIView!
    @IBOutlet weak var passwordTextfieldView: UIView!
    @IBOutlet weak var usernameTextfieldView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfieldView.layer.cornerRadius = 10
        passwordTextfieldView.layer.cornerRadius = 10
        usernameTextfieldView.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 15
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
