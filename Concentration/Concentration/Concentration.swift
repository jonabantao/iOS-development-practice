//
//  Concentration.swift
//  Concentration
//
//  Created by Jonathan Abantao on 6/30/19.
//  Copyright © 2019 Jonathan Abantao. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]() // View cant control isMatching, isFaceUp etc...
    var flipCount = 0
    var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set(newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }

    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): index out of range")
        if !cards[index].isMatched && !cards[index].isFaceUp {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                
                flipCount += 1
                cards[index].isFaceUp = true
            } else {
                // either no cards or 2 cards are face up
                // TODO: Compute negative score when using computed property
//                for flipDownIndex in cards.indices {
//                    if cards[flipDownIndex].isFaceUp {
//                        if cards[flipDownIndex].hasBeenSeen && !cards[flipDownIndex].isMatched {
//                            score -= 1
//                        } else {
//                            cards[flipDownIndex].hasBeenSeen = true
//                        }
//                    }
//
//                    cards[flipDownIndex].isFaceUp = false
//                }
                
                indexOfOneAndOnlyFaceUpCard = index
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
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
