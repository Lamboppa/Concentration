//
//  Concentration.swift
//  concentration
//
//  Created by MonsterHulk on 2018-01-19.
//  Copyright © 2018 AmazingEric. All rights reserved.
//

import Foundation
import UIKit

//struct are value type, gets copied when passing around, swift only copy bits when you mutate it(copy-on-write semantics)
//struct have copy-on-write semantics, class doesn't
struct Concentration {
    
    //var is writable, if let, not writable
    private(set) var cards = [Card]()
    var flipCount: Int
    var score: Int
    
    //already mutatable, if only get, not mutatable
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
            //let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp}
            //return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                //in case index == newValue, isFaceUp = true
            }
        }
    }
    
    
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        flipCount += 1
        cards[index].chosen = true
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    for otherCard in cards.indices {
                        if cards[otherCard] == cards[indexOfOneAndOnlyFaceUpCard!] && otherCard != indexOfOneAndOnlyFaceUpCard {
                            if cards[otherCard].chosen, index != otherCard, score > 0 {
                                score -= 1
                            }
                        }
                    }
                }
                cards[index].isFaceUp = true
                //indexOfOneAndOnlyFaceUpCard = nil
            } else {
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        score = 0
        flipCount = 0
        Card.resetIdentifier()
        for _ in 1...numberOfPairsOfCards {
            let card = Card() //let card figure out identifier
            //putting things in/out of array also copies the card
            cards += [card, card]
            //3 copies, 1 create, 2 diff copy
        }
        //TODO: Shuffle the cards
        for _ in 0...16 {
            cards.swapAt(Int(arc4random_uniform(UInt32(numberOfPairsOfCards*2))), Int(arc4random_uniform(UInt32(numberOfPairsOfCards*2))))
        }
    }
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}








