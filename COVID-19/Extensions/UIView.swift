//
//  File.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-15.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var shadowColor : UIColor? {
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.3
            layer.masksToBounds = false
            layer.shadowRadius = 10
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = false
        }
        get {
            return nil
        }
    }
}
