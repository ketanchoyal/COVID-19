//
//  File.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-15.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: -2, height: 3)
        layer.shadowRadius = 3
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @IBInspectable var shadowColor : UIColor {
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.masksToBounds = false
            layer.shadowRadius = 3
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = false
        }
        get {
            return UIColor.black
        }
    }
}
