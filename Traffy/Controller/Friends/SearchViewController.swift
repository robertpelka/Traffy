//
//  SearchViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 09/12/2021.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextfieldView: UIView!
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var searchTextfield: UITextField!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTableView.dataSource = self
        prepareView()
        searchUsers()
    }
    
    func prepareView() {
        searchTextfieldView.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        searchTextfield.addTarget(self, action: #selector(searchUsers), for: .editingChanged)
    }
    
    @objc func searchUsers() {
        guard let searchText = searchTextfield.text else { return }
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.whereField("username", isGreaterThanOrEqualTo: searchText).whereField("username", isLessThan: searchText + "z").getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching users: \(error.localizedDescription)")
                return
            }
            if let documents = snapshot?.documents {
                self.users = [User]()
                for document in documents {
                    do {
                        if let user = try document.data(as: User.self) {
                            if user.id != currentUserID {
                                self.users.append(user)                                
                            }
                        }
                    }
                    catch let error {
                        print("DEBUG: Error converting document to User type: \(error.localizedDescription)")
                    }
                }
                self.userTableView.reloadData()
            }
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
        let cell = userTableView.dequeueReusableCell(withIdentifier: K.Identifiers.userCell) as! UserTableViewCell
        cell.userID = user.id
        cell.profileImage.load(url: URL(string: user.profileImageURL))
        cell.usernameLabel.text = user.username
        
        return cell
    }
    
    
}
