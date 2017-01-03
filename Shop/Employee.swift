//
//  Cashier.swift
//  Shop
//
//  Created by Igor Voynov on 01.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

class Employee: UIView {
    
    var title: String!
    var queue = [Buyer]()
    var detectingTimer: Timer!
    var buyer: Buyer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        detecting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //
    // фукнции сотрудника
    //
    
    // старт обнаружения покупателя
    func detecting() {
        detectingTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.serviceStart), userInfo: nil, repeats: true)
        self.serviceStart()
    }
    
    // начинаем обслуживание
    func serviceStart() {
        if let buyer = queue.first {
            if buyer.locationX == self.center.x {
                detectingTimer.invalidate() // останавливаем обнаружение
                self.buyer = buyer
                let time = queue.count < 3 ? Timers.sellingSlow : Timers.sellingFast
                let interval = TimeInterval(arc4random_uniform(time)+time) // время продажи
                print(title, "обслуживает", buyer.title, "c", buyer.product.name, "(", interval, "сек )")
                Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.serviceEnd), userInfo: nil, repeats: false)
            }
        }
    }
    
    // окончание обслуживания
    func serviceEnd() {
        action() // что-то происходит
        print(title, "обслужила", buyer.title, "c", buyer.product.name)
        buyer.goHome() // убегаем домой
        queue.remove(at: queue.index(of: buyer)!) // уходим из очереди
        for buyer in queue {
            buyer.position = buyer.position - 1 // подзываем осташихся в очереди
            if buyer.isRun {
                buyer.isCome = true // как закончишь бежать - подойди
            } else {
                buyer.goToEmployee() // если стоишь - подойди
            }
        }
        detecting() // начинаем обнаружение покупателя

    }
    
    // что-то делаем
    func action() {}

}
