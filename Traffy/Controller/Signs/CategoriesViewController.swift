//
//  CategoriesViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 03/12/2021.
//

import UIKit
import Firebase

enum SignType: String {
    case warning = "ostrzegawczy"
    case prohibition = "zakazu"
    case mandatory = "nakazu"
    case information = "informacyjny"
}

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
    
    var category: SignType = .warning
    
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
    
    @IBAction func warningSignsButtonPressed(_ sender: UIButton) {
        category = .warning
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func prohibitionSignsButtonPressed(_ sender: UIButton) {
        category = .prohibition
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func mandatorySignsButtonPressed(_ sender: UIButton) {
        category = .mandatory
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func informationSignsButtonPressed(_ sender: UIButton) {
        category = .information
        performSegue(withIdentifier: K.Segues.goToSignsView, sender: self)
    }
    
    @IBAction func discoverSignButtonPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Segues.goToSignsView {
            let signsVC = segue.destination as! SignsViewController
            signsVC.category = category
        }
    }
    
}
