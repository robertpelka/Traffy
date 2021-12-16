//
//  UserTableViewCell.swift
//  Traffy
//
//  Created by Robert Pelka on 09/12/2021.
//

import UIKit
import Firebase

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    var userID: String = "" {
        didSet {
            checkIfUserIsFollowed { isFollowed in
                self.isFollowed = isFollowed
                if isFollowed {
                    self.changeButtonToUnfollow()
                }
                else {
                    self.changeButtonToFollow()
                }
            }
        }
    }
    var isFollowed = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareView()
    }
    
    func prepareView() {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        addButton.layer.cornerRadius = 15
    }
    
    func changeButtonToUnfollow() {
        self.addButton.setTitle("Usuń", for: .normal)
        self.addButton.setTitleColor(UIColor.white, for: .normal)
        self.addButton.backgroundColor = .clear
        self.addButton.layer.borderColor = UIColor.white.cgColor
        self.addButton.layer.borderWidth = 1
    }
    
    func changeButtonToFollow() {
        self.addButton.setTitle("Dodaj", for: .normal)
        self.addButton.setTitleColor(UIColor.black, for: .normal)
        self.addButton.backgroundColor = UIColor.white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        if !isFollowed {
            followUser()
        }
        else {
            unfollowUser()
        }
    }
    
    func followUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        isFollowed = true
        changeButtonToUnfollow()
        
        K.Collections.users.document(currentUserID).collection("friends").document(userID).setData([:]) { error in
            if let error = error {
                print("DEBUG: Error adding user to the friends list: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func unfollowUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        isFollowed = false
        changeButtonToFollow()
        
        K.Collections.users.document(currentUserID).collection("friends").document(userID).delete { error in
            if let error = error {
                print("DEBUG: Error removing user from the friends list: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func checkIfUserIsFollowed(completion: @escaping (Bool) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).collection("friends").document(userID).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Error checking if user is followed: \(error.localizedDescription)")
                return
            }
            if snapshot?.exists == true {
                completion(true)
            }
            else {
                completion(false)
            }
        }
    }
    
}
