//
//  UserTableViewCell.swift
//  Traffy
//
//  Created by Robert Pelka on 09/12/2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareView()
    }
    
    func prepareView() {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        addButton.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {
    }
    
}
