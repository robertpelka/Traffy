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

            let maskLayerPath = UIBezierPath(roundedRect: bounds, cornerRadius: 7)
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskLayerPath.cgPath
            layer.mask = maskLayer
        }

}
