//
//  FriendsViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 01/12/2021.
//

import UIKit
import Firebase

class FriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        }
        catch let error {
            print("DEBUG: Error signing out: \(error.localizedDescription)")
            return
        }

        let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginView")
        DispatchQueue.main.async {
            self.present(loginView, animated: false, completion: nil)
        }
    }
    
}
