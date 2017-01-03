//
//  Cashier.swift
//  Shop
//
//  Created by Igor Voynov on 05.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

class Cashier: Employee {

    var labelNum: UILabel!
    var labelStatus: UILabel!
 
    var isWork: Bool = true {
        didSet {
            labelStatus.text = isWork ? "open" : "close"
            labelStatus.textColor  = isWork ? UIColor.darkGray : UIColor.red
        }
    }

    var numberOfBuyers = 0 { didSet { labelNum.text = String(numberOfBuyers) } }
    
    override func action() {
        numberOfBuyers += 1 // увиличиваем число обслуженных
        Shop.cashBox.deposit += buyer.item.price // в сейф кладем денежку
        Shop.sold.items.append(buyer.item) // продукт на гарантию
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelNum = UILabel(frame: CGRect(x: -20, y: 0, width: self.frame.width, height: 20))
        labelNum.textColor = UIColor.darkGray
        self.addSubview(labelNum)
        labelStatus = UILabel(frame: CGRect(x: 0, y: -20, width: self.frame.width, height: 20))
        labelStatus.textAlignment = NSTextAlignment.center
        self.addSubview(labelStatus)
        
        let sex = arc4random_uniform(2) == 0 ? "man" : "girl"
        setBackgroundImageWithName("\(sex)Cashier")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
