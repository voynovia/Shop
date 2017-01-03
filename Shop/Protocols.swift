//
//  Protocols.swift
//  Shop
//
//  Created by Igor Voynov on 04.12.16.
//  Copyright © 2016 Igor Voynov. All rights reserved.
//

import Foundation

protocol ProductProto {
    var name: String { get }
    var price: Double { get }
    var size: Double { get }
    var cores: Int { get }
}
