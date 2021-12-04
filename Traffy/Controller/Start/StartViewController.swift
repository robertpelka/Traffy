//
//  StartViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 29/11/2021.
//

import UIKit
import Firebase

class StartViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var questionsCounterLabel: UILabel!
    @IBOutlet weak var signsCounterLabel: UILabel!
    @IBOutlet weak var questionsProgressView: CustomProgressView!
    @IBOutlet weak var signsProgressView: CustomProgressView!
    
    @IBOutlet weak var startLearningButton: UIButton!
    @IBOutlet weak var recognizeSignButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        fetchUser()
    }
    
    func prepareView() {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        startLearningButton.layer.cornerRadius = 15
        recognizeSignButton.layer.cornerRadius = 15
        recognizeSignButton.layer.borderWidth = 2
        recognizeSignButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func fetchUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("DEBUG: Error getting current user id.")
            return
        }
        
        K.Collections.users.document(currentUserID).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching current user: \(error.localizedDescription)")
            }
            
            let user: User?
            do {
                user = try snapshot?.data(as: User.self)
            }
            catch let error {
                print("DEBUG: Error converting document to User type: \(error.localizedDescription)")
                return
            }
            
            if let user = user {
                let numberOfQuestions = 342
                let numberOfSigns = 70
                
                self.profileImage.load(url: URL(string: user.profileImageURL))
                
                self.usernameLabel.text = "Witaj, \(user.username)!"
                
                self.questionsCounterLabel.text = String(user.masteredQuestionsNumber) + " / " +  String(numberOfQuestions)
                self.signsCounterLabel.text = String(user.discoveredSignsNumber) + " / " +  String(numberOfSigns)
                
                let questionsProgress = Float(user.masteredQuestionsNumber) / Float(numberOfQuestions)
                self.questionsProgressView.setProgress(questionsProgress, animated: true)
                
                let signsProgress = Float(user.discoveredSignsNumber) / Float(numberOfSigns)
                self.signsProgressView.setProgress(signsProgress, animated: true)
            }
            
        }
        
    }
    
    @IBAction func startLearningButtonPressed(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func recognizeSignButtonPressed(_ sender: UIButton) {
    }
    
}
