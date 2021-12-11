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
    
    var friendsIDs = [String]()
    var friends = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendTableView.dataSource = self
        
        prepareView()
        
        fetchFriendsIDs()
    }
    
    func prepareView() {
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
    
    func fetchFriendsIDs() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).collection("friends").addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching friends IDs: \(error.localizedDescription)")
                return
            }
            self.friendsIDs = [String]()
            if let documents = snapshot?.documents {
                for document in documents {
                    self.friendsIDs.append(document.documentID)
                }
            }
            self.fetchFriends()
        }
    }
    
    func fetchFriends() {
        if friendsIDs.isEmpty {
            self.friends = [User]()
            self.friendTableView.reloadData()
            return
        }
        let chunkedFriendsIDs = friendsIDs.chunked(into: 10)
        self.friends = [User]()
        for chunkOfIDs in chunkedFriendsIDs {
            K.Collections.users.whereField("id", in: chunkOfIDs).addSnapshotListener { snapshot, error in
                if let error = error {
                    print("DEBUG: Error fetching friends: \(error.localizedDescription)")
                    return
                }
                var friendsChunk = [User]()
                if let documents = snapshot?.documents {
                    for document in documents {
                        do {
                            if let friend = try document.data(as: User.self) {
                                friendsChunk.append(friend)
                            }
                        }
                        catch let error {
                            print("DEBUG: Error converting document to User type: \(error.localizedDescription)")
                        }
                    }
                    self.friends.append(contentsOf: friendsChunk)
                }
                self.friendTableView.reloadData()
            }
        }
    }
    
}

//MARK: - UITableViewDataSource

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = friends[indexPath.row]
        
        let cell = friendTableView.dequeueReusableCell(withIdentifier: K.Identifiers.friendCell) as! FriendTableViewCell
        
        cell.profileImage.load(url: URL(string: friend.profileImageURL))
        cell.usernameLabel.text = friend.username
        
        cell.questionsCounterLabel.text = String(friend.masteredQuestionsNumber) + " / " +  String(K.numberOfQuestions)
        cell.signsCounterLabel.text = String(friend.discoveredSignsNumber) + " / " +  String(K.numberOfSigns)
        
        let questionsProgress = Float(friend.masteredQuestionsNumber) / Float(K.numberOfQuestions)
        cell.questionsProgressView.setProgress(questionsProgress, animated: true)
        
        let signsProgress = Float(friend.discoveredSignsNumber) / Float(K.numberOfSigns)
        cell.signsProgressView.setProgress(signsProgress, animated: true)
        
        return cell
    }
}
