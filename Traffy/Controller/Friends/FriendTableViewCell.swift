//
//  FriendTableViewCell.swift
//  Traffy
//
//  Created by Robert Pelka on 11/12/2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareView()
    }
    
    func prepareView() {
        cellView.layer.cornerRadius = 10
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
