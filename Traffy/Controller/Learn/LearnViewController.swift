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
    
    @IBOutlet weak var trueAnswerButton: UIButton!
    @IBOutlet weak var falseAnswerButton: UIButton!
    
    @IBOutlet weak var aAnswerButton: UIButton!
    @IBOutlet weak var bAnswerButton: UIButton!
    @IBOutlet weak var cAnswerButton: UIButton!
    
    @IBOutlet weak var trueFalseButtonsView: UIStackView!
    @IBOutlet weak var abcButtonsView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }
    
    func prepareView() {
        questionImage.layer.cornerRadius = 10
        
        trueAnswerButton.layer.cornerRadius = 15
        falseAnswerButton.layer.cornerRadius = 15
        
        aAnswerButton.layer.cornerRadius = 15
        bAnswerButton.layer.cornerRadius = 15
        cAnswerButton.layer.cornerRadius = 15
        
        aAnswerButton.titleLabel?.textAlignment = .center
        bAnswerButton.titleLabel?.textAlignment = .center
        cAnswerButton.titleLabel?.textAlignment = .center
    }
    
    func toggleButtonViews() {
        trueFalseButtonsView.isHidden.toggle()
        abcButtonsView.isHidden.toggle()
    }
    
    @IBAction func trueAnswerButtonPressed(_ sender: UIButton) {
        toggleButtonViews()
    }
    
    @IBAction func falseAnswerButtonPressed(_ sender: UIButton) {
        toggleButtonViews()
    }
    
    @IBAction func aAnswerButtonPressed(_ sender: UIButton) {
        toggleButtonViews()
    }
    
    @IBAction func bAnswerButtonPressed(_ sender: UIButton) {
        toggleButtonViews()
    }
    
    @IBAction func cAnswerButtonPressed(_ sender: UIButton) {
        toggleButtonViews()
    }
    
}
