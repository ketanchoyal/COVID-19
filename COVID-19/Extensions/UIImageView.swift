//
//  UIImage.swift
//  COVID-19
//
//  Created by Ketan Choyal on 2020-04-16.
//  Copyright © 2020 Ketan Choyal. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { () in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }
        }
    }
}
