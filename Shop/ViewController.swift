//
//  ViewController.swift
//  Shop
//
//  Created by Igor Voynov on 01.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var xOffset: CGFloat = 10
    let yOffset: CGFloat = 20
    var size: CGFloat = 30
        
    var reserveCashier: Cashier?
    
    var table = Table()
    var manager = Manager()
    
    func setSize() {
        xOffset = view.bounds.width / 3 * 2
        size = (view.bounds.height - yOffset) / 10
    }
    
    func fillingOfStorage() {
        for product in Product.assortment {
            Shop.storage.addProduct(product, count: Int(arc4random_uniform(50)))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSize()
        
        // Заполняем склад товаром
        fillingOfStorage()
        
        // Доска
        table = Table(frame: CGRect(x: 0, y: 0, width: view.frame.midX, height: size*2))
        view.addSubview(table)
        
        // создаем менеджера по заказам и возвратам
        manager = Manager(frame: CGRect(x: xOffset, y: yOffset, width: size, height: size))
        manager.title = "Менеджер"
        view.addSubview(manager)
        
        // создаем кассиров
        for i in stride(from: 2, through: 8, by: 2) {
            let cashier = Cashier(frame: CGRect(x: xOffset, y: size*CGFloat(i) + yOffset, width: size, height: size))
            cashier.title = "Касса"+String(i/2)
            cashier.isWork = i != 8
            view.addSubview(cashier)
            reserveCashier = !cashier.isWork ? cashier : nil
        }
        
        // покупатели бегут
        let interval = TimeInterval(arc4random_uniform(Timers.buyerSlow)+Timers.buyerSlow) // // появление нового покупателя
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(self.goBuyer), userInfo: nil, repeats: true)
        self.goBuyer()
        
        // возвраты бегут
        let intervalReturn = TimeInterval(arc4random_uniform(50)+10) // возврат от 10 до 60 секунд
        Timer.scheduledTimer(timeInterval: intervalReturn, target: self, selector: #selector(self.goBuyerReturn), userInfo: nil, repeats: true)
    }

    func goBuyerReturn() {
        if Shop.sold.items.count > 0 {
            let buyer = Buyer(frame: CGRect(x: -size, y: -size, width: size, height: size))
            view.addSubview(buyer)
            buyer.chooseReturnProduct()
            print(buyer.title, "возвращает товар", buyer.product.name)
            buyer.orientation = manager // бежим возвращать товар
        }
    }
    
    func goBuyer() {
        let rnd = arc4random_uniform(UInt32(Int(size)*8)) + UInt32(Int(size)*2)
        let buyer = Buyer(frame: CGRect(x: -size, y: CGFloat(rnd), width: size, height: size))
        view.addSubview(buyer)
        
        if buyer.chooseProductShop() {
            table.update()
            
            // смотрим самого свободного кассира
            var cashiers = [Cashier]()
            for subview in view.subviews {
                if let cashier = subview as? Cashier {
                    if cashier.isWork {
                        cashiers.append(cashier)
                    }
                }
            }
            
            // если собралась очередь из 4 человек, открываем еще одну кассу
            let min = cashiers.min(by: { $0.queue.count < $1.queue.count }) // касса с минимальной очередью
            switch (min!.queue.count, reserveCashier!.isWork) {
            case (4, false):
                reserveCashier!.isWork = true
            case (1, true):
                reserveCashier!.isWork = false
            default:
                break
            }
            
            let freeCashiers = cashiers.filter({ $0.queue.count == min!.queue.count }) // кассы с мин очередью
            
            // определем ближайшую кассу с минимальной очередью
            buyer.orientation = freeCashiers.min(by: { buyer.getDuration(toPoint: $0.center) < buyer.getDuration(toPoint: $1.center) })
            
        } else {
            print(buyer.title, "не выбрал товар")
            buyer.orientation = manager // бежим заказывать
        }

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
