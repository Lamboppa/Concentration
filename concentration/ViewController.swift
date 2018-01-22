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
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func newGame(_ sender: UIButton) {
        for (_, value) in theme {
            themes.append(value)
        }
        theme.removeAll()
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
    }
    
    func themeReset() {
        for (_, value) in theme {
            themes.append(value)
        }
        theme.removeAll()
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControlState.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.5843137255, blue: 0, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        flipCountLabel.text = "Flips: 0"
        scoreLabel.text = "Score: 0"
    }
    
    @IBAction func changeTheme(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            themeReset()
            themes = ["🐱", "🐹", "🐼", "🐰", "🐻", "🐶", "🐷", "🐸"]
        case 2:
            themeReset()
            themes = ["😃", "😆", "😍", "😇", "🤪", "😘", "😡", "😵"]
        case 3:
            themeReset()
            themes = ["🥐", "🍔", "🍕", "🥪", "🍣", "🌭", "🍟", "🍜"]
        default:
            themeReset()
            themes = ["👻", "🎃", "🤖", "🤯", "🧟‍♂️", "🧛🏻‍♂️", "🦇", "🕸"]
        }
    }
    
    var themes = ["👻", "🎃", "🤖", "🤯", "🧟‍♂️", "🧛🏻‍♂️", "🦇", "🕸"]
    
    var theme = [Int:String]()
    
    @IBAction func touchCard(_ sender: UIButton) {
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if theme[card.identifier] == nil, themes.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(themes.count)))
            theme[card.identifier] = themes.remove(at: randomIndex)
        }
        //how to convert: create a new thing, use the init of new thing to create one
        /*if emoji[card.identifier] != nil {
            return emoji[card.identifier]!
        } else {
            return "?"
        }*/
        return theme[card.identifier] ?? "?"
    }
}

