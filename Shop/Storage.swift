//
//  Storage.swift
//  Shop
//
//  Created by Igor Voynov on 04.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

struct Storage {
    var items = [Item]()
    
    mutating func removeProduct(_ item: Item) {
        let index = items.index(where: { $0.product == item.product })
        if let index = index {
            items.remove(at: index)
        }
    }

    mutating func addProduct(_ product: Product, count: Int = 1) {
        for _ in 0..<count {
            items.append(Item(product))
        }
    }
  
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    func getItem(_ product: Product) -> Item? {
        return items.first(where: { $0.product.name == product.name})
    }
    
    func getRemains(_ product: Product) -> Int {
        return items.filter({ $0.product.name == product.name && $0.broken == false }).count
    }
    
    func getBrokenRemains(_ product: Product) -> Int {
        return items.filter({ $0.product.name == product.name && $0.broken == true }).count
    }
    
}
