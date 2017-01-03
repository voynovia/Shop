//
//  Service.swift
//  Shop
//
//  Created by Igor Voynov on 02.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

class Manager: Employee {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundImageWithName("imgService")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func action() {
        switch buyer.status {
        case .Ok:
            print(buyer.title, "промахнулся, тебе на кассу")
        case .Order:
            print(buyer.title, "заказал", buyer.product.name)
            Shop.storage.addProduct(buyer.product, count: Int(arc4random_uniform(50))) // положили на склад
        case .Return:
            print(buyer.title, "вернул", buyer.product.name)
            
            // принимаем товар
            if let item = Shop.sold.getItem(buyer.product) {
                item.broken = true // товар сломан
                Shop.storage.addItem(item) // товар на склад
                
                let index = Shop.sold.items.index(where: { $0.product.name == buyer.product.name }) // индекс нашего товара в проданных
                Shop.sold.items.remove(at: index!) // убираем из проданных
                Shop.cashBox.deposit -= buyer.product.price // возвращаем деньги
                
            } else {
                print(buyer.product.name, "не из нашего магазина")
            }
            
        }
    }
    
}
