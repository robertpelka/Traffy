//
//  CustomProgressView.swift
//  Traffy
//
//  Created by Robert Pelka on 01/12/2021.
//

import UIKit

class CustomProgressView: UIProgressView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = frame.height / 2
        
        layer.cornerRadius = radius
        clipsToBounds = true
        
        layer.sublayers?[1].cornerRadius = radius
        subviews[1].clipsToBounds = true
    }
    
}
