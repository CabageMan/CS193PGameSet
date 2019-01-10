//
//  GameSet.swift
//  GameSet
//
//  Created by ViktorsMacbook on 08.01.19.
//  Copyright © 2019 Viktor Bednyi Inc. All rights reserved.
//

import Foundation

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

class GameSet {
    // Declare variables
    private (set) var cardsDeck = [Card]()
    private (set) var cardsOnTable = [Card]()
    
    // Game initialization
    init() {
        //var nonShuffledCards = [Card]()
        
        // Fill the array, based on all of variant of combination and shuffle this array
        for number in Card.cardFeatureVariants.allVariants {
            for shape in Card.cardFeatureVariants.allVariants {
                for color in Card.cardFeatureVariants.allVariants {
                    for filling in Card.cardFeatureVariants.allVariants {
                        cardsDeck.append(Card(number: number,
                                              shape: shape,
                                              color: color,
                                              filling: filling))
                    }
                }
            }
        }
        /*
        // Shuffle the array
        for _ in 0..<nonShuffledCards.count {
            cardsDeck.append(nonShuffledCards.remove(at: nonShuffledCards.count.arc4random))
        }
        */
    }
    
    //MARK: Handle main game logic
    
    func deal3Cards(times: Int) {
        if times > 0 && times <= cardsDeck.count/3 {
            if cardsDeck.count > 0 {
                for _ in 0..<times * 3 {
                    if let card = getCardFromDeck() {
                        cardsOnTable.append(card)
                    }
                }
            }
        } else {
            print("The range is wrong")
        }
    }
    
    func getCardFromDeck() -> Card? {
        return cardsDeck.count > 0 ? cardsDeck.remove(at: cardsDeck.count.arc4random) : nil
    }
    
}
