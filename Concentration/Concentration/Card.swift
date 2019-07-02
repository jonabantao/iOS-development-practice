//
//  Card.swift
//  Concentration
//
//  Created by Jonathan Abantao on 6/30/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var hasBeenSeen = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
