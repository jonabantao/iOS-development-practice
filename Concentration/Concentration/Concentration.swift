//
//  Concentration.swift
//  Concentration
//
//  Created by Jonathan Abantao on 6/30/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var flipCount = 0
    var score = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched && !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                
                flipCount += 1
                indexOfOneAndOnlyFaceUpCard = nil
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    if cards[flipDownIndex].isFaceUp {
                        if cards[flipDownIndex].hasBeenSeen && !cards[flipDownIndex].isMatched {
                            score -= 1
                        } else {
                            cards[flipDownIndex].hasBeenSeen = true
                        }
                    }

                    cards[flipDownIndex].isFaceUp = false
                }
                
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].isFaceUp = true
            }
        }
    }
    
    func restartGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].hasBeenSeen = false
        }
        
        flipCount = 0
        score = 0
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}
