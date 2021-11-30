//
//  Extensions.swift
//  Traffy
//
//  Created by Robert Pelka on 30/11/2021.
//

import Foundation
import UIKit

extension UIImage {
    func resize(maxSideLength: CGFloat) -> UIImage {
        let aspectRatio = self.size.width / self.size.height
        let newWidth: CGFloat
        let newHeight: CGFloat
        
        if self.size.width > self.size.height {
            newWidth = maxSideLength
            newHeight = maxSideLength / aspectRatio
        }
        else {
            newHeight = maxSideLength
            newWidth = maxSideLength * aspectRatio
        }
        
        if newWidth < self.size.width {
            let newSize = CGSize(width: newWidth, height: newHeight)
            
            let image = UIGraphicsImageRenderer(size: newSize).image { _ in
                draw(in: CGRect(origin: .zero, size: newSize))
            }
            return image.withRenderingMode(renderingMode)
        }
        else {
            return self
        }
    }
}

extension UIViewController {
    func showAlert(withMessage message: String, andTitle title: String = "Błąd") {
        DispatchQueue.main.async {
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
