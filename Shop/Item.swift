//
//  Products.swift
//  Shop
//
//  Created by Igor Voynov on 05.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

class Item {
    var product: Product!
    var price: Double!
    var broken: Bool = false
    
    init(_ product: Product) {
        self.product = product
        self.price = Double(round(100 * product.price * 1.3 ) / 100) // наценка
    }
}
