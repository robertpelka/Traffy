//
//  SearchViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 09/12/2021.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextfieldView: UIView!
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userTableView.dataSource = self
        prepareView()
    }
    
    func prepareView() {
        searchTextfieldView.layer.cornerRadius = 10
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: K.Identifiers.userCell) as! UserTableViewCell
        cell.usernameLabel.text = "Robert"
    
        return cell
    }
    
    
}
