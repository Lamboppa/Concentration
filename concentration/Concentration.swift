//
//  Concentration.swift
//  concentration
//
//  Created by MonsterHulk on 2018-01-19.
//  Copyright © 2018 AmazingEric. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var flipCount: Int
    var score: Int
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                //in case index == newValue, isFaceUp = true
            }
        }
    }
    
    
    
    func chooseCard(at index: Int) {
        flipCount += 1
        cards[index].chosen = true
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    for otherCard in cards.indices {
                        if cards[otherCard].identifier == cards[indexOfOneAndOnlyFaceUpCard!].identifier && otherCard != indexOfOneAndOnlyFaceUpCard {
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
            //calculated in indexOfOneAndOnlyFaceUpCard
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    
    
    init(numberOfPairsOfCards: Int) {
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
