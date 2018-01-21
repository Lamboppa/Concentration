//
//  Card.swift
//  concentration
//
//  Created by MonsterHulk on 2018-01-19.
//  Copyright © 2018 AmazingEric. All rights reserved.
//

import Foundation

//UI independent
struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    var chosen = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func resetIdentifier() {
        identifierFactory = 0
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
