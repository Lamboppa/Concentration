//
//  ViewController.swift
//  concentration
//
//  Created by MonsterHulk on 2018-01-17.
//  Copyright © 2018 AmazingEric. All rights reserved.
//

import UIKit

//classes get free init with no argument as long as all their var is initialized
class ViewController: UIViewController {
    
    //lazy: doesnt actually initialize until someone grabs it/someone tries to use it
    //lazy cannot have a didset(property observer)
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        for (_, value) in emoji {
            emojiChoices.append(value)
        }
        emoji.removeAll()
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        scoreLabel.text = "Score: 0"
    }
    
    var emojiChoices = ["👻", "🎃", "🤖", "🤯", "🧟‍♂️", "🧛🏻‍♂️", "🦇", "🕸"]
    
    var emoji = [Int:String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("qerjooidv")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        //how to convert: create a new thing, use the init of new thing to create one
        /*if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
            return "?"
        }*/
        return emoji[card.identifier] ?? "?"
    }
}

