//
//  CashBox.swift
//  Shop
//
//  Created by Igor Voynov on 05.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

struct CashBox {
    var deposit: Double = 0.0 { didSet { deposit =  Double( round(100 * deposit ) / 100) }}
}
