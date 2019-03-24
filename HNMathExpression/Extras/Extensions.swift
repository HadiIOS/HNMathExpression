//
//  Extensions.swift
//  HNMathExpression
//
//  Created by Hady Nourallah on 22/03/2019.
//  Copyright © 2019 Mac. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addLiveBackground(_ color: UIColor = UIColor.pink, oColor: UIColor = UIColor.sWhite) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.startPoint = CGPoint(x:0.0, y:0.5)
        gradient.endPoint = CGPoint(x:1.0, y:0.5)
        gradient.colors = [color, oColor]
        gradient.locations =  [-0.5, 1.5]

        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = [color.cgColor, oColor.cgColor]
        animation.toValue = [oColor.cgColor, color.cgColor]
        animation.duration = 5.0
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
      
        gradient.add(animation, forKey: nil)
        self.layer.insertSublayer(gradient, at: 0)
    }
}

extension UIColor {
    static let pink: UIColor = UIColor(red:0.91, green:0.26, blue:0.58, alpha:1.0)
    static let sWhite: UIColor = UIColor(red:0.96, green:0.96, blue:0.98, alpha:1.0)
}

extension UICollectionViewCell {
    static var IDENTIFIER: String {
        return String(describing: self)
    }
    
    static var XIB_FILE: UINib {
        return UINib(nibName: IDENTIFIER, bundle: nil)
    }
}
