//
//  UIImage+Extensions.swift
//  Simpsons Character Viewer
//
//  Created by Steven on 8/26/19.
//  Copyright © 2019 Project Yato. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        self.image = UIImage(named: "default")
        
        if let url = URL(string: urlString) {
            let imageURLString: NSString = "\(url)" as NSString
            
            if let cachedImage = IMAGE_CACHE.object(forKey: imageURLString) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
            }
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            IMAGE_CACHE.setObject(image, forKey: imageURLString)
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
