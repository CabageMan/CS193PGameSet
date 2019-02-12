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
    // Declare constants
    static let defaultNumberOfCardsOnTable = 12
    
    // Declare variables
    private (set) var cardsDeck = [Card]()
    private (set) var cardsOnTable = [Card]()
    private (set) var selectedCards = [Card]()
    private (set) var matchedCards = [Card]()
    private (set) var playerScore = 0
    
    // Get all sets on the table
    var setsOnTable: [[Int]] {
        var sets = [[Int]]()
        if cardsOnTable.count > 2 {
            for firstCardIndex in 0..<cardsOnTable.count {
                for secondCardIndex in (firstCardIndex + 1)..<cardsOnTable.count {
                    for thirdCardIndex in (secondCardIndex + 1)..<cardsOnTable.count {
                        let cards = [cardsOnTable[firstCardIndex], cardsOnTable[secondCardIndex], cardsOnTable[thirdCardIndex]]
                        if isMatched(choosen: cards) {
                            sets.append([firstCardIndex, secondCardIndex, thirdCardIndex])
                        }
                    }
                }
            }
        }
        return sets
    }
    
    // Game initialization
    init() {
        // Fill the array, based on all of variant of combination
        for number in Card.cardFeatureVariants.allVariants {
            for shape in Card.cardFeatureVariants.allVariants {
                for color in Card.cardFeatureVariants.allVariants {
                    for filling in Card.cardFeatureVariants.allVariants {
                        cardsDeck.append(Card(number: number, shape: shape, color: color, filling: filling))
                    }
                }
            }
        }
    }
    
    //MARK: Handle main game logic
    func chooseCard(at index: Int) {
        let chosenCard = cardsOnTable[index]
        // Check if choosen card is already chose before then it must be unselected
        // else check for matching
        if selectedCards.contains(chosenCard) && selectedCards.count <= 2 {
            let indexOfSelectedCard = selectedCards.index(of: chosenCard)
            selectedCards.remove(at: indexOfSelectedCard!)
        } else if selectedCards.count == 2 && !selectedCards.contains(chosenCard) {
            selectedCards.append(chosenCard)
            
            if isMatched(choosen: selectedCards) {
                matchedCards = selectedCards
                playerScore += 1
            } else {
                if playerScore > 0 {
                    playerScore -= 1
                }
            }
        } else {
            if !matchedCards.isEmpty {
                // Check whether is it possible to deal more cards
                // if it possible, then replace the matching cards on the table
                // else remove cards from table
                if cardsOnTable.count <= GameSet.defaultNumberOfCardsOnTable {
                    replace(onTable: selectedCards)
                } else {
                    remove(fromTable: selectedCards)
                }
                matchedCards.removeAll()
                selectedCards.removeAll()
            } else if selectedCards.count == 3 {
                selectedCards.removeAll()
            }
            selectedCards.append(chosenCard)
        }
    }
    
    func isMatched(choosen cards: [Card]) -> Bool {
        // One more check if array with selected cards contain 3 elemetns
        guard cards.count == 3 else { return false }
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
        // If player deal more 3 cards, he loose 1 point
        if times == 1 && playerScore > 0 {
            playerScore -= 1
        }
        if times > 0 && times <= cardsDeck.count/3 && cardsDeck.count >= 3 && cardsOnTable.count < GameSet.defaultNumberOfCardsOnTable*2 {
            for _ in 0..<times * 3 {
                if let card = getCardFromDeck() {
                    cardsOnTable.append(card)
                }
            }
        } else {
            print("The range is wrong")
        }
    }
    
    func replace(onTable cards: [Card]) {
        for card in cards {
            if let indexOfChoosenCard = cardsOnTable.index(of: card), let newCard = getCardFromDeck() {
                cardsOnTable.remove(at: indexOfChoosenCard)
                cardsOnTable.insert(newCard, at: indexOfChoosenCard)
            }
        }
    }
    
    func remove(fromTable cards: [Card]) {
        for card in cards {
            if let indexOfChoosenCard = cardsOnTable.index(of: card) {
                cardsOnTable.remove(at: indexOfChoosenCard)
            }
        }
    }
    
    // Get random card from the deck
    func getCardFromDeck() -> Card? {
        return cardsDeck.count > 0 ? cardsDeck.remove(at: cardsDeck.count.arc4random) : nil
    }
    
    func getHint() -> [Card]? {
        if setsOnTable.count > 0 {
            var hintedCards = [Card]()
            for indexOfHintedCard in setsOnTable[setsOnTable.count.arc4random] {
                hintedCards.append(cardsOnTable[indexOfHintedCard])
            }
            return hintedCards
        } else {
            return nil
        }
    }
}
