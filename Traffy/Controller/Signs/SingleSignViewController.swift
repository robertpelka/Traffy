//
//  SingleSignViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 16/12/2021.
//

import UIKit

class SingleSignViewController: UIViewController {

    @IBOutlet weak var signImageView: UIImageView!
    @IBOutlet weak var signIDLabel: UILabel!
    @IBOutlet weak var signNameLabel: UILabel!
    @IBOutlet weak var discoverLabel: UILabel!
    @IBOutlet weak var signDescriptionLabel: UILabel!

    var sign: Sign?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
    }
    
    func prepareView() {
        guard let sign = sign else {
            print("DEBUG: Error unwraping a sign.")
            return
        }

        signImageView.load(url: URL(string: sign.image))
        signIDLabel.text = sign.id
        signNameLabel.text = sign.name
        signDescriptionLabel.text = sign.description
    }
    
}
