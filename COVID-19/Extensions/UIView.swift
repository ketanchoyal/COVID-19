//
//  File.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-15.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: -2, height: 3)
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @IBInspectable var shadowColor : UIColor {
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.7
            layer.masksToBounds = false
            layer.shadowRadius = 5
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.shadowOffset = CGSize(width: -2, height: 3)
        }
        get {
            return UIColor.black
        }
    }
}
