//
//  ViewController.swift
//  Concentration
//
//  Created by Jonathan Abantao on 6/29/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() {
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
    
    
    @IBAction func restartGame(_ sender: UIButton) {
        emojiChoices = nil
        emoji.removeAll()
        game.restartGame()
        updateViewFromModel()
    }
    
    var emojiMap = [
        ["🐶","🐱","🐭","🐹","🐰","🦊","🐻","🐷"],
        ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍈"],
        ["🚗","🚕","🚙","🚌","🚎","🚓","🚒","🚐"],
        ["🇩🇿","🇻🇬","🇨🇱","🇱🇷","🇫🇲","🇯🇲","🇲🇲","🇳🇺"],
    ]
    
    var emoji = [Int:String]()
    var emojiChoices: [String]?
    
    func emoji(for card: Card) -> String {
        if emojiChoices == nil {
            let randomEmojiIndex = Int(arc4random_uniform(UInt32(emojiMap.count)))
            emojiChoices = emojiMap[randomEmojiIndex]
        }
        
        if emoji[card.identifier] == nil, emojiChoices!.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices!.count)))
            emoji[card.identifier] = emojiChoices!.remove(at: randomIndex)
            
        }
        
        return emoji[card.identifier] ?? "?"
    }
}

