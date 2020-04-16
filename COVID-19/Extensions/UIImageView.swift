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
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
