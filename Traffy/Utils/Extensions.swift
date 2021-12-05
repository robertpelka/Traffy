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

extension UIImageView {
    func load(url: URL?) {
        guard let url = url else {
            print("DEBUG: Error loading image, the URL is nil.")
            return
        }
        
        self.image = UIImage(named: "loadingImageBackground")
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        indicatorView.startAnimating()
        self.addSubview(indicatorView)
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        indicatorView.removeFromSuperview()
                        self?.image = image
                    }
                }
            }
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
