//
//  ViewController.swift
//  concentration
//
//  Created by MonsterHulk on 2018-01-17.
//  Copyright © 2018 AmazingEric. All rights reserved.
//

import UIKit

//classes get free init with no argument as long as all their var is initialized
class ConcentrationViewController: UIViewController {
    
    //lazy: doesnt actually initialize until someone grabs it/someone tries to use it
    //lazy cannot have a didset(property observer)
    //lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)

    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
//    {
//        didSet {
//            updateFlipCountLabel()
//        }
//    }
    
    
//    private(set) var flipCount = 0 {
//        didset {
//            updateFlipCountLabel()
//        }
//    }
//
//    private func updateFlipCountLabel() {
//        let attributes: [NSAttributedStringKey:Any] = [
//            .strokeWidth = 5.0,
//            .strokeColor = UIColor.orange
//        ]
//        let attributedString = NSAttributedString(string:"Flips:\(game.flipCount)", attributes: attributes)
//        flipCountLabel.attributedText = attributedString
//    }
    
    @IBOutlet private weak var scoreLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func newGame(_ sender: UIButton) {
        for (_, value) in emoji {
            emojiChoices.append(value)
        }
        emoji.removeAll()
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
    }
    
//    private func themeReset() {
//        for (_, value) in emoji {
//            emojiChoices.append(value)
//        }
//        emoji.removeAll()
//        for index in cardButtons.indices {
//            cardButtons[index].setTitle("", for: UIControlState.normal)
//            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
//        }
//        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
//        flipCountLabel.text = "Flips: 0"
//        scoreLabel.text = "Score: 0"
//    }
//
//    @IBAction private func changeTheme(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 1:
//            themeReset()
//            emojiChoices = "🐱🐹🐼🐰🐻🐶🐷🐸"
//        case 2:
//            themeReset()
//            emojiChoices = "😃😆😍😇🤪😘😡😵"
//        case 3:
//            themeReset()
//            emojiChoices = "🥐🍔🍕🥪🍣🌭🍟🍜"
//        default:
//            themeReset()
//            emojiChoices = "👻🎃🤖🤯🧟‍♂️🧛🏻‍♂️🦇🕸"
//        }
//    }
    
//    private var themes = ["👻", "🎃", "🤖", "🤯", "🧟‍♂️", "🧛🏻‍♂️", "🦇", "🕸"]
    private var emojiChoices = "👻🎃🤖🤯🧟‍♂️🧛🏻‍♂️🦇🕸"
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emoji = [Card:String]()
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("qerjooidv")
        }
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
                }
            }
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Score: \(game.score)"
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
//            let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
//            theme[card.identifier] = themes.remove(at: randomIndex)
            let randomSringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomSringIndex))
        }
        //how to convert: create a new thing, use the init of new thing to create one
        /*if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
            return "?"
        }*/
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}


