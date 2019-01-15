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
    private (set) var selectedCards = [Card]()
    
    // Game initialization
    init() {
        // Fill the array, based on all of variant of combination
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
    }
    
    //MARK: Handle main game logic
    
    func chooseCard(at index: Int) {
        if selectedCards.contains(cardsOnTable[index]) && selectedCards.count < 3 {
            let indexOfSelectedCard = selectedCards.index(of: cardsOnTable[index])
            selectedCards.remove(at: indexOfSelectedCard!)
        } else if selectedCards.count == 3 {
            if isMatched(choosen: selectedCards) {
                print(":)")
                replace(choosen: selectedCards)
                selectedCards.removeAll()
                selectedCards.append(cardsOnTable[index])
            } else {
                print(":(")
                selectedCards.removeAll()
                selectedCards.append(cardsOnTable[index])
            }
        } else {
            selectedCards.append(cardsOnTable[index])
        }
    }
    
    func isMatched(choosen cards: [Card]) -> Bool {
        // One more check if array with selected cards contain 3 elemetns
        guard cards.count == 3 else {
            return false
        }
        // If all variants are the same, the remainder of devision sum of they by 3 will be 0
        // this is true for the case when all variants are completely different
        let variantsSum = [
            cards.reduce(0, {$0 + $1.symbolsNumber.rawValue}),
            cards.reduce(0, {$0 + $1.symbolsColor.rawValue}),
            cards.reduce(0, {$0 + $1.symbolsShape.rawValue}),
            cards.reduce(0, {$0 + $1.symbolsFilling.rawValue})
        ]
        
        return variantsSum.reduce(true, {$0 && ($1 % 3 == 0)})
    }
    
    func deal3Cards(times: Int) {
        if times > 0 && times <= cardsDeck.count/3 && cardsDeck.count >= 3 {
            for _ in 0..<times * 3 {
                if let card = getCardFromDeck() {
                    cardsOnTable.append(card)
                }
            }
        } else {
            print("The range is wrong")
        }
    }
    
    func replace(choosen cards: [Card]) {
        for card in cards {
            if let indexOfChoosenCard = cardsOnTable.index(of: card), let newCard = getCardFromDeck() {
                cardsOnTable.remove(at: indexOfChoosenCard)
                cardsOnTable.insert(newCard, at: indexOfChoosenCard)
            }
        }
    }
    
    // Get random card from the deck
    func getCardFromDeck() -> Card? {
        return cardsDeck.count > 0 ? cardsDeck.remove(at: cardsDeck.count.arc4random) : nil
    }
    
}
