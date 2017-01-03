//
//  People.swift
//  Shop
//
//  Created by Igor Voynov on 01.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import UIKit

class Buyer: UIView {
    
    // формируем покупателя
    static var num = 1
    var title: String! = "Покуматель"+String(Buyer.num)
    var sex = "man"
    var last = 10
    
    var orientation: Employee! { // куда бежать
        didSet {
            orientation.queue.append(self) // в очередь
            position = orientation.queue.index(of: self) // позиция покупателя
            goToEmployee() // бежим к сотруднику
        }
    }
    
    var product: Product! // товар в руках
    var item: Item!
    
    // свойства
    var isRun = false
    var isCome = false
    
    var status = StatusBuyer.Ok
    
    var position: Int!
    var locationX: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Buyer.num += 1
        
        let isMan: Bool = arc4random_uniform(2) == 0 ? false : true
        sex = isMan ? "man" : "girl"
        last = isMan ? 10 : 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        switch status {
        case .Ok:
            print("Довольный", title, "ушел домой с", product.name)
        case .Order:
            print("Грустный", title, "ушел домой ни с чем, он заказал", product.name)
        case .Return:
            print("Злой", title, "ушел домой ни с чем, ему продали сломаный", product.name )
        }
    }
    
    //
    // Человеческие функции
    //
    
    // расчитываем время движения покупателя
    func getDuration(toPoint: CGPoint) -> TimeInterval {
        let xDist: CGFloat = toPoint.x - self.center.x
        let yDist: CGFloat = toPoint.y - self.center.y
        let distance: CGFloat = sqrt((xDist * xDist) + (yDist * yDist))
        return TimeInterval(distance / max(self.frame.width, self.frame.height))
    }
    
    // бежим к сотруднику
    func goToEmployee() {
        isRun = true // начинаем бежать
        setAnimationBackground(sex: sex, state: "Run", last: last)
        UIView.animate(withDuration: getDuration(toPoint: self.orientation.center), animations: {
            // по позиции знаем куда бежать
            let xOffset = CGFloat(self.position) * self.frame.width
            self.center.x = self.orientation.center.x - xOffset
            self.center.y = self.orientation.center.y + self.orientation.frame.height/2
        }, completion: {_ in
            self.isRun = false // останавливаемся
            self.setAnimationBackground(sex: self.sex, state: "Idle", last: 10)
            self.locationX = self.center.x // даем понять что покупатель подошел
            if self.isCome { // если покупателю было сказано подойти
                self.isCome = false
                self.goToEmployee() // бежим к сотруднику
            }
        })
    }

    // бежим домой
    func goHome() {
        isRun = true // начинаем бежать
        self.setAnimationBackground(sex: self.sex, state: "Run", last: self.last)
        let x = self.bounds.midX + (self.superview?.frame.maxX)! // за пределы экрана по х
        UIView.animate(withDuration: getDuration(toPoint: CGPoint(x: x, y: self.center.y)), animations: {
            self.center.x = x
        }, completion: {_ in
            self.removeFromSuperview()
        })
    }
    
    // покупатель выбирает себе то что хочет купить
    func chooseProductShop() -> Bool {
        let products = Product.assortment // смотрим ассортимент товара
        product = products[Int(arc4random_uniform(UInt32(products.count)))] // выбираем любой
        if Shop.storage.getRemains(product) > 0 { // если есть на складе
            print(title, "схватил", product.name)
            item = Shop.storage.getItem(product) // берем в руки
            Shop.storage.removeProduct(item) // убираем со склада
            return true
        }
        status = .Order
        return false
    }
    
    // назначаем покупателю то что он вернет
    func chooseReturnProduct() {
        product = Shop.sold.items[Int(arc4random_uniform(UInt32(Shop.sold.items.count)))].product
        status = .Return
    }
    
}
