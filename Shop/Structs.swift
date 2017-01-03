//
//  Structs.swift
//  Shop
//
//  Created by Igor Voynov on 01.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

public struct Timers {
    // время продажи
    static let sellingSlow: UInt32 = 5
    static let sellingFast: UInt32 = 3
    
    // появление нового покупателя
    static let buyerSlow: UInt32 = 2
    static let buyerFast: UInt32 = 1
}

public struct Shop {
    static var storage = Storage()
    static var sold = Sold()
    static var cashBox = CashBox()
}
