//
//  ViewController.swift
//  Concentration
//
//  Created by Jonathan Abantao on 6/29/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreCountLabel.text = "Score: \(game.score)"
    }
    
    
    @IBAction private func restartGame(_ sender: UIButton) {
        emojiChoices = nil
        emoji.removeAll()
        game.restartGame()
        updateViewFromModel()
    }
    
    private var emojiMap = [
        ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐷"],
        ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍈"],
        ["🚗","🚕","🚙","🚌","🚎","🚓","🚒","🚐"],
        ["🇩🇿","🇻🇬","🇨🇱","🇱🇷","🇫🇲","🇯🇲","🇲🇲","🇳🇺"],
    ]
    
    private var emoji = [Card:String]()
    
    private var emojiChoices: [String]?
    
    private func emoji(for card: Card) -> String {
        if emojiChoices == nil {
            let randomEmojiIndex = emojiMap.count.arc4random
            emojiChoices = emojiMap[randomEmojiIndex]
        }
        
        if emoji[card] == nil, emojiChoices!.count > 0 {
            let randomIndex = emojiChoices!.count.arc4random
            emoji[card] = emojiChoices!.remove(at: randomIndex)
            
        }
        
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

