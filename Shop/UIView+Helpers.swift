//
//  UIView+Helpers.swift
//  Shop
//
//  Created by Igor Voynov on 02.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

extension UIView {
    
    func setBackgroundImageWithName(_ name: String) {
        let bgImage = UIImageView(image: UIImage(named: name))
        bgImage.frame = self.bounds
        bgImage.contentMode = UIViewContentMode.scaleAspectFit
        self.insertSubview(bgImage, at: 0)
        self.backgroundColor = UIColor.clear
    }
    
    func setAnimationBackground(sex: String, state: String, last: Int) {
        self.backgroundColor = UIColor.clear
        
        var bgImage = UIImageView()
        if let bg = self.subviews.first as? UIImageView {
            bgImage = bg
            bgImage.stopAnimating()
        } else {
            bgImage.frame = self.bounds
            bgImage.animationDuration = 1
            self.insertSubview(bgImage, at: 0)
        }
        
        var images = [UIImage]()
        for i in 1...last {
            images.append(UIImage(named:"\(sex+state+String(i))")!)
        }
        bgImage.animationImages = images

        bgImage.startAnimating()
    }
    
}
