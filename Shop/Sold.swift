//
//  CashBox.swift
//  Shop
//
//  Created by Igor Voynov on 05.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

struct Sold {
    var items = [Item]()
    
    func getItem(_ product: Product) -> Item? {
        return items.first(where: { $0.product.name == product.name})
    }
    
}
