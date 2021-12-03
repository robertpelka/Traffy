//
//  CategoriesViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 03/12/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var warningSignsButton: UIButton!
    @IBOutlet weak var prohibitionSignsButton: UIButton!
    @IBOutlet weak var mandatorySignsButton: UIButton!
    @IBOutlet weak var informationSignsButton: UIButton!
    
    @IBOutlet weak var warningSignsLabel: UILabel!
    @IBOutlet weak var prohibitionSignsLabel: UILabel!
    @IBOutlet weak var mandatorySignsLabel: UILabel!
    @IBOutlet weak var informationSignsLabel: UILabel!
    
    @IBOutlet weak var discoverSignButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
    }
    
    func prepareView() {
        warningSignsButton.layer.cornerRadius = 15
        prohibitionSignsButton.layer.cornerRadius = 15
        mandatorySignsButton.layer.cornerRadius = 15
        informationSignsButton.layer.cornerRadius = 15
        
        discoverSignButton.layer.cornerRadius = 15
    }

    @IBAction func discoverSignButtonPressed(_ sender: UIButton) {
    }
    
}
