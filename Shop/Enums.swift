//
//  Enums.swift
//  Shop
//
//  Created by Igor Voynov on 04.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

enum StatusBuyer {
    case Ok, Return, Order
}

enum Product: ProductProto {
    case iPhoneSE, iPhone7, iPhone7Plus, iMac21, iMac27
    
    static let assortment = [iPhoneSE, iPhone7, iPhone7Plus, iMac21, iMac27]
    
    var name: String {
        switch self {
        case .iPhoneSE:
            return "iPhone SE"
        case .iPhone7:
            return "iPhone 7"
        case .iPhone7Plus:
            return "iPhone 7 Plus"
        case .iMac21:
            return "iMac 21"
        case .iMac27:
            return "iMac 27"
        }
    }
    var price: Double {
        switch self {
        case .iPhoneSE:
            return 300.00
        case .iPhone7:
            return 649.00
        case .iPhone7Plus:
            return 769.00
        case .iMac21:
            return 1099.00
        case .iMac27:
            return 1499.00
        }
    }
    var size: Double {
        switch self {
        case .iPhoneSE:
            return 4.0
        case .iPhone7:
            return 4.7
        case .iPhone7Plus:
            return 5.5
        case .iMac21:
            return 21.5
        case .iMac27:
            return 27.0
        }
    }
    var cores: Int {
        switch self {
        case .iPhoneSE:
            return 1
        case .iPhone7:
            return 2
        case .iPhone7Plus:
            return 4
        case .iMac21:
            return 4
        case .iMac27:
            return 8
        }
    }
}
