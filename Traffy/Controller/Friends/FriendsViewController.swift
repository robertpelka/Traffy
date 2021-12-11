//
//  FriendsViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 01/12/2021.
//

import UIKit
import Firebase

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var friendTableView: UITableView!
    @IBOutlet weak var addFriendsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendTableView.dataSource = self
        friendTableView.contentInset.bottom = 94
        addFriendsButton.layer.cornerRadius = 15
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

//MARK: - UITableViewDataSource

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendTableView.dequeueReusableCell(withIdentifier: K.Identifiers.friendCell) as! FriendTableViewCell
        return cell
    }
}
