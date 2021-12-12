//
//  SignsViewController.swift
//  Traffy
//
//  Created by Robert Pelka on 12/12/2021.
//

import UIKit

class SignsViewController: UIViewController {

    @IBOutlet weak var signsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signsCollectionView.dataSource = self
        signsCollectionView.delegate = self
        
        prepareView()
    }
    
    func prepareView() {
        signsCollectionView.contentInset.top = 30
        signsCollectionView.contentInset.bottom = 30
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

extension SignsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = signsCollectionView.dequeueReusableCell(withReuseIdentifier: K.Identifiers.signCell, for: indexPath)
        
         return cell
    }
}

extension SignsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = Double(UIScreen.main.bounds.width)
        let spacing: Double = 25
        let numberOfCellsInRow: Double = 3
        let cellWidth = (screenWidth - (numberOfCellsInRow + 1) * spacing) / numberOfCellsInRow
        
        return CGSize(width: cellWidth, height: cellWidth * 1.1)
    }
}
