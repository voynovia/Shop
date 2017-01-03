//
//  Table.swift
//  Shop
//
//  Created by Igor Voynov on 04.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

class Table: UIView {
    
    var widthLabelProduct: CGFloat!
    var widthLabelDigit: CGFloat!
    let height: CGFloat = 20
    let cashBoxLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        widthLabelProduct = frame.width / 4 * 2
        widthLabelDigit = frame.width / 4
        
        // Бабло в сейфе
        cashBoxLabel.frame = CGRect(x: 0, y: 5, width: frame.width, height: 10)
        cashBoxLabel.textAlignment = .center
        cashBoxLabel.textColor = UIColor.blue
        cashBoxLabel.font = cashBoxLabel.font.withSize(12)
        cashBoxLabel.accessibilityIdentifier = "CashBox"
        addSubview(cashBoxLabel)
        
        update()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func update() {
        
        cashBoxLabel.text = "$"+String(Shop.cashBox.deposit)
        
        for subview in subviews {
            if subview.accessibilityIdentifier != "CashBox" {
                subview.removeFromSuperview()
            }
        }
        
        var i = 0
        for product in Product.assortment {
            let labelProduct = UILabel(frame: CGRect(x: 10, y: height*CGFloat(i) + 20, width: widthLabelProduct, height: height))
            labelProduct.textColor = UIColor.darkGray
            labelProduct.text = product.name
            labelProduct.textAlignment = .left
            labelProduct.font = labelProduct.font.withSize(14)
            self.addSubview(labelProduct)
            
            let remains = Shop.storage.getRemains(product)
            let labelRemains = UILabel(frame: CGRect(x: widthLabelProduct, y: height*CGFloat(i) + 20, width: widthLabelDigit, height: height))
            labelRemains.text = String(remains)
            labelRemains.textAlignment = .right
            labelRemains.textColor = remains > 3 ? UIColor.darkGray : UIColor.red
            self.addSubview(labelRemains)
            
            let solds = Shop.sold.items.filter({ $0.product.name == product.name }).count
            let labelSold = UILabel(frame: CGRect(x: widthLabelProduct + widthLabelDigit, y: height*CGFloat(i) + 20, width: widthLabelDigit, height: height))
            labelSold.textColor = UIColor.darkGray
            labelSold.text = String(solds)
            labelSold.textAlignment = .right
            self.addSubview(labelSold)
            
            let returns = Shop.storage.getBrokenRemains(product)
            let labelReturns = UILabel(frame: CGRect(x: widthLabelProduct + widthLabelProduct, y: height*CGFloat(i) + 20, width: widthLabelDigit, height: height))
            labelReturns.textColor = UIColor.darkGray
            labelReturns.text = String(returns)
            labelReturns.textAlignment = .right
            self.addSubview(labelReturns)
            
            i += 1
        }
    }
    
}
