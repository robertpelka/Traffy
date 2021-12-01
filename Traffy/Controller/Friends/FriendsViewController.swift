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
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
