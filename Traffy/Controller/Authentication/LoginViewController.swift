//
//  LoginViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 28/11/2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfieldView: UIView!
    @IBOutlet weak var passwordTextfieldView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfieldView.layer.cornerRadius = 10
        passwordTextfieldView.layer.cornerRadius = 10
        loginButton.layer.cornerRadius = 15
        
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
