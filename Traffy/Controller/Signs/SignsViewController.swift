//
//  SignsViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 12/12/2021.
//

import UIKit

class SignsViewController: UIViewController {
    
    @IBOutlet weak var signsCollectionView: UICollectionView!
    
    var category: SignType = .warning
    var signs = [Sign]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signsCollectionView.dataSource = self
        signsCollectionView.delegate = self
        
        prepareView()
        
        fetchSigns()
    }
    
    func prepareView() {
        signsCollectionView.contentInset.top = 30
        signsCollectionView.contentInset.bottom = 30
        
        switch category {
        case .warning:
            self.title = "Znaki Ostrzegawcze"
        case .prohibition:
            self.title = "Znaki Zakazu"
        case .mandatory:
            self.title = "Znaki Nakazu"
        case .information:
            self.title = "Znaki Informacyjne"
        }
    }
    
    func fetchSigns() {
        K.Collections.signs.whereField("type", isEqualTo: category.rawValue).getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Error fetching signs: \(error.localizedDescription)")
                return
            }
            if let documents = snapshot?.documents {
                for document in documents {
                    do {
                        if let sign = try document.data(as: Sign.self) {
                            self.signs.append(sign)
                        }
                    }
                    catch let error {
                        print("DEBUG: Error converting document to Sign type: \(error.localizedDescription)")
                    }
                }
                self.signs.sort { $0.id.localizedStandardCompare($1.id) == ComparisonResult.orderedAscending }
                self.signsCollectionView.reloadData()
            }
        }
    }
    
}

//MARK: - UICollectionViewDataSource

extension SignsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sign = signs[indexPath.row]
        
        let cell = signsCollectionView.dequeueReusableCell(withReuseIdentifier: K.Identifiers.signCell, for: indexPath) as! SignsCollectionViewCell
        cell.signNameLabel.text = sign.id
        cell.signImageView.load(url: URL(string: sign.image))
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SignsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Double(UIScreen.main.bounds.width)
        let spacing: Double = 25
        let numberOfCellsInRow: Double = 3
        let cellWidth = (screenWidth - (numberOfCellsInRow + 1) * spacing) / numberOfCellsInRow
        
        return CGSize(width: cellWidth, height: cellWidth * 1.1)
    }
}
