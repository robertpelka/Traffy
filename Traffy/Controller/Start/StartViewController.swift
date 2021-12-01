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
    @IBOutlet weak var startLearningButton: UIButton!
    @IBOutlet weak var recognizeSignButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        startLearningButton.layer.cornerRadius = 15
        recognizeSignButton.layer.cornerRadius = 15
        recognizeSignButton.layer.borderWidth = 2
        recognizeSignButton.layer.borderColor = UIColor.white.cgColor
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
