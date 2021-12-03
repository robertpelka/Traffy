//
//  LearnViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 03/12/2021.
//

import UIKit

class LearnViewController: UIViewController {

    @IBOutlet weak var levelOfMasteryImage: UIImageView!
    @IBOutlet weak var questionImage: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var aAnswerButton: UIButton!
    @IBOutlet weak var bAnswerButton: UIButton!
    @IBOutlet weak var cAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }
    
    func prepareView() {
        aAnswerButton.titleLabel?.textAlignment = .center
        bAnswerButton.titleLabel?.textAlignment = .center
        cAnswerButton.titleLabel?.textAlignment = .center
        
        aAnswerButton.layer.cornerRadius = 15
        bAnswerButton.layer.cornerRadius = 15
        cAnswerButton.layer.cornerRadius = 15
    }
    
    @IBAction func aAnswerButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func bAnswerButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func cAnswerButtonPressed(_ sender: UIButton) {
    }
    
}
